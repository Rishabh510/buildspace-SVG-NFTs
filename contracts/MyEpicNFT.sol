// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.1;

// We first import some OpenZeppelin Contracts.
import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

// We inherit the contract we imported. This means we'll have access
// to the inherited contract's methods.
contract MyEpicNFT is ERC721URIStorage {
    // Magic given to us by OpenZeppelin to help us keep track of tokenIds.
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    uint256 maxSupply = 50;

    // string openSvg =
    //     "<svg width='1400' height='980' xmlns='http://www.w3.org/2000/svg' version='1.1' xml:space='preserve'><defs><linearGradient id='XMLID_11_' x1='0.34444' y1='0.26248' x2='0.70953' y2='0.81923'><stop offset='0' stop-color='#282829'/><stop offset='0.4626' stop-color='#333334'/><stop offset='1' stop-color='#141414'/></linearGradient><linearGradient id='XMLID_12_' x1='0.25369' y1='-0.03754' x2='0.60402' y2='0.73992'><stop offset='0' stop-color='#83621A'/><stop offset='0.3503' stop-color='#D5A949'/><stop offset='0.6429' stop-color='#EEE29B'/><stop offset='0.8078' stop-color='#DBB75D'/><stop offset='1' stop-color='#9B7726'/></linearGradient><linearGradient id='XMLID_13_' x1='0.28538' y1='0.00637' x2='0.63299' y2='0.80614'><stop offset='0' stop-color='#BC8C2E'/><stop offset='0.1633' stop-color='#D5A949'/><stop offset='0.3435' stop-color='#EEE29B'/><stop offset='0.4643' stop-color='#DBB75D'/><stop offset='0.5289' stop-color='#CCA244'/><stop offset='0.6241' stop-color='#D3AC50'/><stop offset='0.6922' stop-color='#E9D88C'/><stop offset='0.8282' stop-color='#DDBC66'/><stop offset='1' stop-color='#C49535'/></linearGradient><linearGradient id='SVGID_396_' x1='0.29258' y1='0.03603' x2='0.66807' y2='0.8451'><stop offset='0' stop-color='#BC8C2E'/><stop offset='0.2585' stop-color='#D5A949'/><stop offset='0.5272' stop-color='#EEE29B'/><stop offset='0.7262' stop-color='#DBB75D'/><stop offset='1' stop-color='#C49535'/></linearGradient><linearGradient id='SVGID_397_' x1='0.38383' y1='-0.05614' x2='0.70788' y2='1.16556'><stop offset='0' stop-color='#BC8C2E'/><stop offset='0.2585' stop-color='#D5A949'/><stop offset='0.5272' stop-color='#EEE29B'/><stop offset='0.7262' stop-color='#DBB75D'/><stop offset='1' stop-color='#C49535'/></linearGradient><linearGradient id='SVGID_398_' x1='0.28665' y1='-0.04474' x2='0.71872' y2='0.98548'><stop offset='0' stop-color='#BC8C2E'/><stop offset='0.2585' stop-color='#D5A949'/><stop offset='0.5272' stop-color='#EEE29B'/><stop offset='0.7262' stop-color='#DBB75D'/><stop offset='1' stop-color='#C49535'/></linearGradient><radialGradient gradientTransform='translate(0,0.175) scale(1,0.65)' r='0.87965' cy='0.5' cx='0.5' spreadMethod='pad' id='svg_17'><stop offset='0' stop-opacity='0.99219' stop-color='#fcfcfc'/><stop offset='1' stop-opacity='0.98828' stop-color='#f9e686'/></radialGradient></defs><g><title>Layer 1</title><rect fill-opacity='0.9' id='svg_14' height='1010.76923' width='1426.15385' y='-14.95726' x='-11.62393' fill='url(#svg_17)'/><text id='XMLID_73_' transform='matrix(1 0 0 1 454.097 544.227)' class='st420 st421 st422' fill='#C39333' font-size='100.8924px' y='3.07692' x='-72.30769'>";
    // string closeSvg =
    //     "</text><line id='XMLID_71_' class='st423' x1='328.50001' y1='563.4' x2='1071.50001' y2='563.4' fill='none' stroke-miterlimit='10' stroke='#000000'/><g id='XMLID_72_'/><g id='XMLID_1_'><text transform='matrix(1 0 0 1 516.5782 893.0001)' class='st417 st426 st419' fill='#2B292A' font-size='20px' id='svg_426'>DATE</text></g><line class='st427' x1='411.5' y1='863' x2='673' y2='863' fill='none' stroke='#2B292A' stroke-miterlimit='10' id='svg_427'/><g id='XMLID_5_'><text transform='matrix(1 0 0 1 885.5763 893.0002)' class='st417 st426 st419' fill='#2B292A' font-size='20px' id='svg_428'>SIGNATURE</text></g><line class='st427' x1='806.5' y1='863' x2='1068' y2='863' fill='none' stroke='#2B292A' stroke-miterlimit='10' id='svg_429'/><text id='svg_2' transform='matrix(1 0 0 1 454.097 544.227)' class='st420 st421 st422' fill='#C39333' font-size='64' y='130.76923' x='40' font-weight='bold'>EVENT NAME</text><g id='svg_4'/><text fill='#2B292A' x='637.32375' y='715.81197' id='svg_5' font-size='24' text-anchor='start' xml:space='preserve' font-style='italic'>organized by</text><text fill='#2B292A' x='515.19622' y='447.96056' id='svg_6' font-size='24' text-anchor='start' xml:space='preserve' font-style='italic'>This certificate is proudly presented to</text><text fill='#2B292A' x='611.78417' y='603.50427' id='svg_7' font-size='24' text-anchor='start' xml:space='preserve' font-style='italic'>for being a part of</text><text id='svg_8' transform='matrix(1 0 0 1 454.097 544.227)' class='st420 st421 st422' fill='#C39333' font-size='64' y='243.07692' x='38.46153' font-weight='bold'>ORG. NAME</text><text style='cursor: move;' font-weight='bold' id='svg_1' transform='matrix(0.908151 0 0 0.908151 468.934 510.219)' class='st420 st421 st422' fill='#C39333' font-size='100.8924px' y='-236.42127' x='186.48256'>CERTIFICATE</text><text font-weight='bold' id='svg_10' transform='matrix(0.908151 0 0 0.908151 468.934 510.219)' class='st420 st421 st422' fill='#C39333' font-size='48' y='-165.27079' x='308.45481'>OF APPRECIATION</text><g id='svg_13'><path class='st379' d='m1400,0l-601.8,0c140.5,31.2 403.9,104.8 601.8,249.2l0,-249.2z' fill='#2a4c59' id='svg_381'/><path class='st380' d='m798.2,0l-227.2,0c0,0 616,57 829,381l0,-131.8c-197.9,-144.4 -461.3,-218 -601.8,-249.2z' fill='#d1ae00' id='svg_382'/><path class='st381' d='m1026.2,0l-1026.2,0l0,194.2c82,3.2 558.3,11.7 1026.2,-194.2z' fill='#2a4c59' id='svg_383'/><path class='st382' d='m0,194.2l0,82.9c0,0 487,25.9 1089,-277.1l-62.8,0c-467.9,205.9 -944.2,197.4 -1026.2,194.2z' fill='#d1ae00' id='svg_384'/><path class='st383' d='m1400,884.3l0,-71.3c0,0 -279,112 -700,112s-700,-112 -700,-112l0,72.2c82.9,20.4 328.7,71.8 700,71.8c376.9,0 621.9,-53 700,-72.7z' fill='#d1ae00' id='svg_385'/><path class='st384' d='m700,957c-371.3,0 -617.1,-51.4 -700,-71.8l0,94.8l1400,0l0,-95.7c-78.1,19.7 -323.1,72.7 -700,72.7z' fill='#2a4c59' id='svg_386'/><rect x='119.9' y='-1.1' class='st385' width='151.9' height='221.6' fill='#d1ae00' id='svg_387'/><g id='svg_11'><g id='XMLID_105_'><path id='XMLID_118_' class='st386' d='m196,141.2c-59.6,0 -108.2,48.5 -108.2,108.2c0,59.6 48.5,108.2 108.2,108.2c59.6,0 108.2,-48.5 108.2,-108.2c0,-59.7 -48.5,-108.2 -108.2,-108.2z' fill='url(#XMLID_11_)'/><path id='XMLID_115_' class='st387' d='m336.4,245.6c-1.5,-5.1 -4.3,-9.8 -8.1,-13.8c-2.8,-3.1 -7.4,-8.7 -8.7,-15.3c-2,-9.8 0.8,-16.8 0.8,-16.8s4.8,-12.2 -2.6,-23.4c-7.5,-11.2 -19,-13.1 -19,-13.1s-11.8,-2.3 -18.7,-10.5c-6.9,-8.1 -7.5,-15.3 -7.5,-15.3s-2.2,-12.9 -17.2,-18.1c-10.5,-3.6 -18.3,-1.1 -22,0.8c-3.3,1.7 -7,2.7 -10.7,2.7c-2.4,0 -5.1,-0.2 -8,-0.9c-7.9,-2 -11.6,-6.5 -11.6,-6.5s-10.8,-10.8 -25.9,-8.1c-15.2,2.7 -19.9,14.6 -19.9,14.6s-2.6,7.2 -12.4,9.9c-9.8,2.7 -13.3,0.8 -13.3,0.8s-15.7,-3.6 -26.1,5.7c-10.4,9.3 -9.6,22.6 -9.6,22.6s-0.2,9.4 -6.5,16.4c-4.4,8.3 -13,11.6 -13,11.6s-12.7,3.9 -17.8,16.9c-5.1,13 3.8,26.4 3.8,26.4s3.1,2.6 3.9,12.7c0.8,10.1 -5,15.1 -5,15.1s-9.5,8.6 -6.7,23.8c2.8,15.2 16.7,21.4 16.7,21.4s5.6,1.9 10.2,8.6c1.7,2.5 2.9,5 3.7,7.1c1.2,3.5 1.6,7.2 1.2,10.9c-0.5,4.2 -0.1,12.3 6.9,20.8c10.1,12.3 22.9,9.8 22.9,9.8s6.8,-2.1 16.9,1.6c10.1,3.6 16.4,13.8 16.4,13.8s5.8,10.1 19,13.1c13.1,3.1 22.9,-5.8 22.9,-5.8s5.5,-5.1 15.4,-6.6c6.6,-1.1 13.5,1.2 17.4,2.8c5,2.1 10.4,3.1 15.8,2.7c3.2,-0.2 6.8,-0.9 10.3,-2.4c11.7,-4.8 14,-16.1 14,-16.1s1.8,-7.4 7.2,-12.7c5.5,-5.2 7.6,-5.5 20.6,-8.5c13.1,-3.2 18.1,-14.4 18.1,-14.4c1.1,-1.2 8.5,-9.5 7,-21.8c-1.6,-13.3 -2.2,-15.4 0.8,-22.3c3,-6.9 9.3,-11.1 9.3,-11.1s9.8,-6.1 10.2,-18.8c0.4,-3.7 -0.2,-7.3 -1.1,-10.3zm-140.4,111.9c-59.7,0 -108.2,-48.6 -108.2,-108.2c0,-59.7 48.5,-108.3 108.2,-108.3c59.7,0 108.2,48.6 108.2,108.2c0,59.8 -48.5,108.3 -108.2,108.3z' fill='url(#XMLID_12_)'/><g id='XMLID_111_'><path id='XMLID_112_' class='st388' d='m196,367.3c-65.1,0 -118.1,-53 -118.1,-118.1c0,-65.1 53,-118.1 118.1,-118.1s118.1,53 118.1,118.1c0,65.2 -53,118.1 -118.1,118.1zm0,-226.2c-59.7,0 -108.2,48.5 -108.2,108.2s48.5,108.2 108.2,108.2s108.2,-48.5 108.2,-108.2s-48.5,-108.2 -108.2,-108.2z' fill='url(#XMLID_13_)'/></g></g><g id='XMLID_99_'><g id='svg_400'><polygon class='st399' points='157.1,289.7 160.1,295.8 166.8,296.8 162,301.5 163.1,308.2 157.1,305 151.1,308.2 152.3,301.5      147.4,296.8 154.1,295.8    ' fill='url(#SVGID_396_)' id='svg_401'/></g></g><g id='XMLID_93_'><g id='svg_402'><polygon class='st400' points='234.9,289.7 237.9,295.8 244.6,296.8 239.8,301.5 240.9,308.2 234.9,305 228.9,308.2 230,301.5      225.2,296.8 231.9,295.8    ' fill='url(#SVGID_397_)' id='svg_403'/></g></g><g id='XMLID_87_'><g id='svg_404'><polygon class='st401' points='196,312.5 199,318.6 205.7,319.6 200.9,324.4 202,331 196,327.9 190,331 191.1,324.4 186.3,319.6      193,318.6    ' fill='url(#SVGID_398_)' id='svg_405'/></g></g><text fill='#C39333' x='103.0784' y='254.7393' id='svg_9' font-size='48' text-anchor='start' xml:space='preserve' stroke='null' transform='matrix(0.811418 0 0 0.811418 15.5056 38.3916)'>CertificETH</text></g></g></g></svg>";

    string openSvg =
        "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";
    string closeSvg = "</text></svg>";

    // We need to pass the name of our NFTs token and its symbol.
    constructor() ERC721("SquareNFT", "SQUARE") {
        console.log("This is my NFT contract. Woah!");
    }

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    event CustomNFTMinted(address sender, uint256 tokenId);

    function customNFT(string memory myName) public {
        uint256 newItemId = _tokenIds.current();
        require(
            maxSupply > newItemId,
            "SOLD OUT: There's a mint limit of 50 NFTs."
        );

        string memory finalSvg = string(
            abi.encodePacked(openSvg, myName, closeSvg)
        );

        // Get all the JSON metadata in place and base64 encode it.
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',
                        // We set the title of our NFT as the generated word.
                        myName,
                        '", "description": "',
                        "This is my description [HARCODED]",
                        '", "image": "data:image/svg+xml;base64,',
                        // We add data:image/svg+xml;base64 and then append our base64 encode our svg.
                        Base64.encode(bytes(finalSvg)),
                        '"}'
                    )
                )
            )
        );

        // Just like before, we prepend data:application/json;base64, to our data.
        string memory finalTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        console.log("\n--------------------");
        console.log(finalTokenUri);
        console.log("--------------------\n");
        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, finalTokenUri);
        console.log(
            "An NFT w/ ID %s has been minted to %s",
            newItemId,
            msg.sender
        );
        emit CustomNFTMinted(msg.sender, newItemId);
        _tokenIds.increment();
    }

    // A function our user will hit to get their NFT.
    function makeAnEpicNFT() public {
        // Get the current tokenId, this starts at 0.
        uint256 newItemId = _tokenIds.current();

        // Actually mint the NFT to the sender using msg.sender.
        _safeMint(msg.sender, newItemId);

        // Set the NFTs data.
        _setTokenURI(
            newItemId,
            "data:application/json;base64,ewogICAgIm5hbWUiOiAiQ2VydGlmaWNFVEgyIiwKICAgICJkZXNjcmlwdGlvbiI6ICJkZXNjcmlwdGlvbiBvZiBORlQiLAogICAgImltYWdlIjogImRhdGE6aW1hZ2Uvc3ZnK3htbDtiYXNlNjQsUEhOMlp5QjRiV3h1Y3owaWFIUjBjRG92TDNkM2R5NTNNeTV2Y21jdk1qQXdNQzl6ZG1jaUlIQnlaWE5sY25abFFYTndaV04wVW1GMGFXODlJbmhOYVc1WlRXbHVJRzFsWlhRaUlIWnBaWGRDYjNnOUlqQWdNQ0F6TlRBZ016VXdJajRLSUNBZ0lEeHpkSGxzWlQ0dVltRnpaU0I3SUdacGJHdzZJSGRvYVhSbE95Qm1iMjUwTFdaaGJXbHNlVG9nYzJWeWFXWTdJR1p2Ym5RdGMybDZaVG9nTVRSd2VEc2dmVHd2YzNSNWJHVStDaUFnSUNBOGNtVmpkQ0IzYVdSMGFEMGlNVEF3SlNJZ2FHVnBaMmgwUFNJeE1EQWxJaUJtYVd4c1BTSmliR0ZqYXlJZ0x6NEtJQ0FnSUR4MFpYaDBJSGc5SWpVd0pTSWdlVDBpTkRBbElpQmpiR0Z6Y3owaVltRnpaU0lnWkc5dGFXNWhiblF0WW1GelpXeHBibVU5SW0xcFpHUnNaU0lnZEdWNGRDMWhibU5vYjNJOUltMXBaR1JzWlNJK1VtbHphR0ZpYUNCU1lXbDZZV1JoUEM5MFpYaDBQZ29nSUR4MFpYaDBJSGc5SWpjd0pTSWdlVDBpTXpBbElpQmpiR0Z6Y3owaVltRnpaU0lnWkc5dGFXNWhiblF0WW1GelpXeHBibVU5SW0xcFpHUnNaU0lnZEdWNGRDMWhibU5vYjNJOUltMXBaR1JzWlNJK1JHVjJabTlzYVc4OEwzUmxlSFErQ2lBZ1BIUmxlSFFnZUQwaU1qQWxJaUI1UFNJek1DVWlJR05zWVhOelBTSmlZWE5sSWlCa2IyMXBibUZ1ZEMxaVlYTmxiR2x1WlQwaWJXbGtaR3hsSWlCMFpYaDBMV0Z1WTJodmNqMGliV2xrWkd4bElqNVVhR1VnUlhSb1pYSnVZV3h6UEM5MFpYaDBQZ284TDNOMlp6ND0iCn0KCg=="
        );

        console.log(
            "An NFT w/ ID %s has been minted to %s",
            newItemId,
            msg.sender
        );

        // Increment the counter for when the next NFT is minted.
        _tokenIds.increment();
    }
}
