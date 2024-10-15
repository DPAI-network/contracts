// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {Script} from "forge-std/Script.sol"; // solhint-disable
import {console} from "forge-std/console.sol";

import {IDPAIStaking} from "contracts/IDPAIStaking.sol";

contract DeployContractMigration is Script {
    uint256 public immutable privateKey;
    address public contractAddress;

    constructor() {
        privateKey = vm.envUint("PRIVATE_KEY");
        contractAddress = vm.envAddress("DPAISTAKING_PROXY");
    }

    function run() external {
        IDPAIStaking.StakeMultiple[]
            memory staked = new IDPAIStaking.StakeMultiple[](200);
        staked[0] = IDPAIStaking.StakeMultiple(
            10000000000000000000000000,
            0x54fc5811E34786D738b84ED05587A0088d6710c8
        );
        staked[1] = IDPAIStaking.StakeMultiple(
            161514797606259000000000,
            0xBc041877218EFCC989095999f3e3a0Fb20b174af
        );
        staked[2] = IDPAIStaking.StakeMultiple(
            114216233251616000000000,
            0x17bEc8B05c84c04494B52B7172dF1365Bb885852
        );
        staked[3] = IDPAIStaking.StakeMultiple(
            2389286930412860000000,
            0x4a563692fB0583b90205571067B031087229d257
        );
        staked[4] = IDPAIStaking.StakeMultiple(
            582950053645859000000000,
            0x218f3Cba601963A7e448c530105A2e2869f62e5c
        );
        staked[5] = IDPAIStaking.StakeMultiple(
            19851139254719200000000,
            0x67c5b5dA8b0fF0Fd07bE90fd392f7c3ecEBF774b
        );
        staked[6] = IDPAIStaking.StakeMultiple(
            811078627885620000000,
            0x7Dd679D560606D7bA551Ba3807D3d1959135880b
        );
        staked[7] = IDPAIStaking.StakeMultiple(
            33350085521166000000000,
            0x90bD818Ca73Bd410D93c0b8b9370E708D68B09A1
        );
        staked[8] = IDPAIStaking.StakeMultiple(
            6775850510197190000000,
            0x9b10049623Ab827aa0455b7DC26293faCF04120a
        );
        staked[9] = IDPAIStaking.StakeMultiple(
            119932397838210000000000,
            0xB5BeD1B05094f6Fe6D847A2082F35A6d71c189c7
        );
        staked[10] = IDPAIStaking.StakeMultiple(
            300014985773326000000000,
            0x4399B12279662d8F268E29057B3FF5FF36bdf657
        );
        staked[11] = IDPAIStaking.StakeMultiple(
            20222696685866700000000,
            0x1962B6Cc831094bAc2Eb6961cd10Ce04dfE1982f
        );
        staked[12] = IDPAIStaking.StakeMultiple(
            14081415753150700000000,
            0x1973d5478C89AF9Af60Bf68FcAaC80dc1ef61971
        );
        staked[13] = IDPAIStaking.StakeMultiple(
            3450174394736970000000,
            0xc3f826cA32d63d3cF1CAB5aa99Bf19d6EC041f95
        );
        staked[14] = IDPAIStaking.StakeMultiple(
            9251313928529860000000,
            0x11afbac65db80B0BD53c345f1f8C13f0b2502CFA
        );
        staked[15] = IDPAIStaking.StakeMultiple(
            4208494561639190000000,
            0x68d7b8D4A697B1D58C04c3cE5C6Ec43883760C7a
        );
        staked[16] = IDPAIStaking.StakeMultiple(
            56596589830276600000000,
            0xB501e1c99030c9E4b93d17dCc4ce032911CB2b46
        );
        staked[17] = IDPAIStaking.StakeMultiple(
            3724623369306490000000,
            0x5D065E1Aa2f8002651Db8f1cf57CEB55a5a6103D
        );
        staked[18] = IDPAIStaking.StakeMultiple(
            30424153667979000000000,
            0xF26B594bB576856041fE6c1dAc1f3441dbe6Fc91
        );
        staked[19] = IDPAIStaking.StakeMultiple(
            2644348597360630000000000,
            0x9C8d7653A66d31F426e8b0219b65Fa50b97E0BB4
        );
        staked[20] = IDPAIStaking.StakeMultiple(
            44132565324635300000000,
            0xF2A1f12519D71598b4F23607CcCD11078bB8d49D
        );
        staked[21] = IDPAIStaking.StakeMultiple(
            11945531729393600000000,
            0xB2E7181252b2c5286A59f8F4Ff991f76d1a2D641
        );
        staked[22] = IDPAIStaking.StakeMultiple(
            18549174649588800000000,
            0x0b12fF91788AE8ee2398b5eb772c9fa425839b83
        );
        staked[23] = IDPAIStaking.StakeMultiple(
            1317114239357240000000000,
            0x6469a798d4B46C074d3A279FAaeed614BcF6CF3A
        );
        staked[24] = IDPAIStaking.StakeMultiple(
            4534228468508360000000,
            0x8110c36d2C8d4603398F776cd0dA082b498646e7
        );
        staked[25] = IDPAIStaking.StakeMultiple(
            48855889600708200000000,
            0xb79E9BDCDF84d655c2Df86B64A82B22F8C9300CC
        );
        staked[26] = IDPAIStaking.StakeMultiple(
            35390198807735500000000,
            0x966d20ed1FbCCB4C8903547c3049ebF51cf21187
        );
        staked[27] = IDPAIStaking.StakeMultiple(
            157283015065268000000000,
            0x966d20ed1FbCCB4C8903547c3049ebF51cf21187
        );
        staked[28] = IDPAIStaking.StakeMultiple(
            30100051323259500000000,
            0x9ea5c377746F1398252184Df88EAfb4bF9d2285C
        );
        staked[29] = IDPAIStaking.StakeMultiple(
            78496822228696600000000,
            0x8e713Df3f63C3E39CE596d5cf5EdD7Ce7049e5f2
        );
        staked[30] = IDPAIStaking.StakeMultiple(
            2524134486288740000000,
            0xfb54c2d3B6CB75C1936B9363AcFECfD2b58cDB51
        );
        staked[31] = IDPAIStaking.StakeMultiple(
            30126496288987600000000,
            0x17785c5533B5D6DA7B6B5b456464bb16eE23f709
        );
        staked[32] = IDPAIStaking.StakeMultiple(
            135059833838752000000000,
            0x532277a1E4129E22dd2634e069A524BE41857541
        );
        staked[33] = IDPAIStaking.StakeMultiple(
            2536165488762970000000,
            0xF1cc46717851a7fE5EAf8cecA7Ef2eaCDe5FbDb6
        );
        staked[34] = IDPAIStaking.StakeMultiple(
            2406788938065880000000,
            0xedA547C51e36150a24900B0A822bcde7FAc3BC45
        );
        staked[35] = IDPAIStaking.StakeMultiple(
            3641958161228430000000,
            0x80b8A2c11B02e7660695d56F4f915F1D848AaeA8
        );
        staked[36] = IDPAIStaking.StakeMultiple(
            8942999630506610000000,
            0x132b3D61841E8882ffa1eFCDD0ce1A199179f1b6
        );
        staked[37] = IDPAIStaking.StakeMultiple(
            197405781320687000000000,
            0xB64549b3AF82bAA21aDae86fB0839903451a3871
        );
        staked[38] = IDPAIStaking.StakeMultiple(
            5132445262670430000000,
            0xc4e66Ab5FAD47EC77B9cA68F9ea26aA4D5C78250
        );
        staked[39] = IDPAIStaking.StakeMultiple(
            24383462999268600000000,
            0xef0C45156A9e1e2c5700486567041BD698201e4f
        );
        staked[40] = IDPAIStaking.StakeMultiple(
            7085029999999990000000,
            0x14054AAec3b0043f335614fCb3368bc3a547a34A
        );
        staked[41] = IDPAIStaking.StakeMultiple(
            236955445414193000000000,
            0xE8eB02823cCCda263Be6210e048d674A3c4dDCa2
        );
        staked[42] = IDPAIStaking.StakeMultiple(
            23238689890409000000000,
            0xf3Fe613A7c036A6b87661dc203812c6F86934A33
        );
        staked[43] = IDPAIStaking.StakeMultiple(
            191764018895273000000,
            0x2B3625bB11699937FaFBe8c3D45D9c2D54BB8e0a
        );
        staked[44] = IDPAIStaking.StakeMultiple(
            224244875544418000000000,
            0xb98dB99bD298bB5dABbF5b4B3eA96f4dD87Fb2ad
        );
        staked[45] = IDPAIStaking.StakeMultiple(
            128122783059919000000000,
            0xCd5783bC20d6EA530119d0481a7fA4d20ad99A32
        );
        staked[46] = IDPAIStaking.StakeMultiple(
            70078558414323800000000,
            0x893588bB1040abfd2d820Fb997dD43CC22De1311
        );
        staked[47] = IDPAIStaking.StakeMultiple(
            1867974002684390000000,
            0x5509a4F6b83c7369546defC62ee06138F0F6e42E
        );
        staked[48] = IDPAIStaking.StakeMultiple(
            120832151450777000000000,
            0xf16eb8d066994Be8a456577ea08D8D6e7c934C1D
        );
        staked[49] = IDPAIStaking.StakeMultiple(
            539994977661775000000000,
            0x16473a0D35C1B2Aca91E07fA981f045bcca0867d
        );
        staked[50] = IDPAIStaking.StakeMultiple(
            120224125691912000000000,
            0x2385458625f69068ee8812393A3537F59baaE252
        );
        staked[51] = IDPAIStaking.StakeMultiple(
            19727307394144400000000,
            0xffC1bC7bAe162c624EEcc94680Dfe88B4490888b
        );
        staked[52] = IDPAIStaking.StakeMultiple(
            45285366217563500000000,
            0xdC5912c1C93Ae602A6241742Af61b066AFF2a50c
        );
        staked[53] = IDPAIStaking.StakeMultiple(
            76696500790968600000000,
            0x299dA12E4A7b78a64d8eF8B1eCB2928fEAa50B9F
        );
        staked[54] = IDPAIStaking.StakeMultiple(
            6011156471128940000000,
            0xBdF783203Bb5088043727312c0444ED1F7085BD9
        );
        staked[55] = IDPAIStaking.StakeMultiple(
            74073974416337300000000,
            0x5A907b4A319EB63Ebb92d1BA9aCB9022ccCfd212
        );
        staked[56] = IDPAIStaking.StakeMultiple(
            18968348999464400000000,
            0xc02a62cB2666f01cf19E3af0D59Bca10bc7D76A6
        );
        staked[57] = IDPAIStaking.StakeMultiple(
            2235484265314830000000,
            0x1A043097380A27390404BbC99657CeE22327C401
        );
        staked[58] = IDPAIStaking.StakeMultiple(
            26870232220191900000000,
            0x09F44ddB9575838bD61Cd75f2d7a7F7D5A3F1AE0
        );
        staked[59] = IDPAIStaking.StakeMultiple(
            12187445821286600000000,
            0xE82f90d0c93C05D1136FFD345a15739657a0a82a
        );
        staked[60] = IDPAIStaking.StakeMultiple(
            7656649128089060000000,
            0x6c39d246A9d8EB2E02305042d5A8D7382296F71f
        );
        staked[61] = IDPAIStaking.StakeMultiple(
            8845890307681440000000,
            0xaC237A5ad22fC87FeBfAa212a3DfeAeb32eA3733
        );
        staked[62] = IDPAIStaking.StakeMultiple(
            13344247606834900000000,
            0xdED2F61758E1b0D7BFD53E73467C1F6a68f11989
        );
        staked[63] = IDPAIStaking.StakeMultiple(
            10858619172527300000000,
            0xDa99d60efC1ec150ac0d153E64613cb4efed5B54
        );
        staked[64] = IDPAIStaking.StakeMultiple(
            16268233178296700000000,
            0xbf85dA882364Ef5d6af571196b1B391894ddA292
        );
        staked[65] = IDPAIStaking.StakeMultiple(
            22970658025064700000000,
            0x1B6befE81264080454a9926011CaB8E09869d862
        );
        staked[66] = IDPAIStaking.StakeMultiple(
            21508141796337700000000,
            0x99F4Ca8CA8954b52f4f56EDD30A11C13c2DEDaC0
        );
        staked[67] = IDPAIStaking.StakeMultiple(
            88629104271705700000000,
            0xc48f7D9c8A839e2A0114524B4Cce461ed356c5e9
        );
        staked[68] = IDPAIStaking.StakeMultiple(
            9438622414303270000000,
            0xb422B85a342152C1286904c3CAAd1b692198a589
        );
        staked[69] = IDPAIStaking.StakeMultiple(
            69037454452961300000000,
            0x87027945D66e6bE9E56792EC69A8B605B21d7a09
        );
        staked[70] = IDPAIStaking.StakeMultiple(
            26030994332872300000000,
            0x6F841Bb9717a280a650D368f5302b43C74B02A4E
        );
        staked[71] = IDPAIStaking.StakeMultiple(
            76597113709206900000000,
            0xa034ee1d4DB66Edb9093815Db32cDdE030e6433b
        );
        staked[72] = IDPAIStaking.StakeMultiple(
            31368418968031500000000,
            0x94ED7722E05E079aB1d1d92c18463c422E7E0Ea8
        );
        staked[73] = IDPAIStaking.StakeMultiple(
            318593816656009000000000,
            0xB242A506c27D35619bae591d2d8CD698615Cc3b2
        );
        staked[74] = IDPAIStaking.StakeMultiple(
            11794842334054600000000,
            0xC018dE2CE4F5c13Ee08c6c14F53207Ef064D39A0
        );
        staked[75] = IDPAIStaking.StakeMultiple(
            21695771759489300000000,
            0x455fC0324cDc0be6957171aC305b27E215b35A0A
        );
        staked[76] = IDPAIStaking.StakeMultiple(
            1593138490893940000000,
            0x90Ae84d3B5DCb4c017777B21Ad8E522d778E31b1
        );
        staked[77] = IDPAIStaking.StakeMultiple(
            16316915910085500000000,
            0xAA79f4D51d486090787E8153367093f4f36242e0
        );
        staked[78] = IDPAIStaking.StakeMultiple(
            23396700663636900000000,
            0x193aC77F9168d191BA58503f652e45A5270ff82e
        );
        staked[79] = IDPAIStaking.StakeMultiple(
            551660377150933000000000,
            0x65C25c0087B4135Cc4Dcf1CDc47e8C89A2b21F54
        );
        staked[80] = IDPAIStaking.StakeMultiple(
            3472815790678740000000,
            0x384765D5F849A3FF0dbdD8AC609725ab6f256788
        );
        staked[81] = IDPAIStaking.StakeMultiple(
            10890291005524900000000,
            0x13c4a32471b1865234c135B5f0C4355Db8c88c1e
        );
        staked[82] = IDPAIStaking.StakeMultiple(
            5000000000000000000000,
            0xff4C0A32FbA7d17418Ac670F6c6D3e6dcB410c36
        );
        staked[83] = IDPAIStaking.StakeMultiple(
            31420400813221700000000,
            0x422C86036D7eFe28866AE4bF76c445AA517886c9
        );
        staked[84] = IDPAIStaking.StakeMultiple(
            3069400607834420000000,
            0xF24589520211e1b960344816769Ac9C983aD5E02
        );
        staked[85] = IDPAIStaking.StakeMultiple(
            3401713508563490000000,
            0x431f007Dc9E521D4c798f108fE07A1f00a825426
        );
        staked[86] = IDPAIStaking.StakeMultiple(
            4074592037390330000000,
            0x8712Ef4Ac682Bf73A5af6191cC21Ee77Fb27d19c
        );
        staked[87] = IDPAIStaking.StakeMultiple(
            801750954584912000000,
            0x375d5B73d4f4238Af9C7e6aAdac95Bfc5c939840
        );
        staked[88] = IDPAIStaking.StakeMultiple(
            84332932172095500000000,
            0x5614264b6970A94337DB8812BcB14F99e42C0C58
        );
        staked[89] = IDPAIStaking.StakeMultiple(
            4877133655544630000000,
            0x8aa79ccdBd10082a9af3f195354442775DE136a6
        );
        staked[90] = IDPAIStaking.StakeMultiple(
            16797453890440800000000,
            0x40480D7C5658A2E0cBCA0b9783590695C700dc63
        );
        staked[91] = IDPAIStaking.StakeMultiple(
            4169311996067010000000,
            0x59b9399404187Afd97fF5C305ff9dCc8C1DC34c3
        );
        staked[92] = IDPAIStaking.StakeMultiple(
            10630592116585300000000,
            0xf49Aa73C65B9d1467e57A92E56d00b6B000A4a05
        );
        staked[93] = IDPAIStaking.StakeMultiple(
            115658434883313000000,
            0x223D1bdF8A628E22b437F1C0E844665CD6036135
        );
        staked[94] = IDPAIStaking.StakeMultiple(
            314006164588753000000,
            0x23BB80309bdF0E8Bcd3FD70a8C567EE20c187534
        );
        staked[95] = IDPAIStaking.StakeMultiple(
            13331714006191000000000,
            0xdAcCE40c0Ad58Bc6A46016BbE24b6a79fFc99b34
        );
        staked[96] = IDPAIStaking.StakeMultiple(
            18393089245198600000000,
            0xF04c6C85765c2fFf92cEB3BF6dd37aaEDf58AA26
        );
        staked[97] = IDPAIStaking.StakeMultiple(
            2245344997007850000000,
            0x1d842ae0594Dc925E3DD95E2fc9e800c49A44AdD
        );
        staked[98] = IDPAIStaking.StakeMultiple(
            3796682690165940000000,
            0xC644Dc2509BA40D023c63F1aE326ed271Ef222e7
        );
        staked[99] = IDPAIStaking.StakeMultiple(
            1000000000000000000000000,
            0x54fc5811E34786D738b84ED05587A0088d6710c8
        );
        staked[100] = IDPAIStaking.StakeMultiple(
            56824928318288100000000,
            0x3a7AF82433C1e26b75D6cc8c6ee7a5758b9128B4
        );
        staked[101] = IDPAIStaking.StakeMultiple(
            398319625683554000000000,
            0xb9880e9f6aCE7bcbc42aaC08e5b12c660835D442
        );
        staked[102] = IDPAIStaking.StakeMultiple(
            259511711405854000000000,
            0x1ea9bA3FE02FA26faa74116ad49B2CB0d78FB883
        );
        staked[103] = IDPAIStaking.StakeMultiple(
            3746620825675490000000,
            0x20164Ec274CDd3Ba87d6B19da43F424B547Bd112
        );
        staked[104] = IDPAIStaking.StakeMultiple(
            909843306658709000000,
            0x789A85B9E6E29d6f53f51D37BF83e17A1447B39E
        );
        staked[105] = IDPAIStaking.StakeMultiple(
            19096385314133800000000,
            0x169f0f4F7d3eF9889C95eD7555B2aEC974a0C50d
        );
        staked[106] = IDPAIStaking.StakeMultiple(
            67381118367028200000000,
            0x14640F51c54a211e0b8a2121C988Cc29F0F9d7B8
        );
        staked[107] = IDPAIStaking.StakeMultiple(
            25801188435741100000000,
            0x4A71f3b036D378eCB724Ea109FBEDd6b2F3d3F12
        );
        staked[108] = IDPAIStaking.StakeMultiple(
            17867403774727100000000,
            0x3D12aA1C2165A57114aaEF2367540C83D4754632
        );
        staked[109] = IDPAIStaking.StakeMultiple(
            40044927398152600000000,
            0x55FDDB81DeD103A0dD10922b08bE0b67D664A244
        );
        staked[110] = IDPAIStaking.StakeMultiple(
            13085931237875100000000,
            0x31b7713b1CDFa8deE88ffC0af0c9a1C9eCA59aCf
        );
        staked[111] = IDPAIStaking.StakeMultiple(
            3281468845812080000000,
            0x9C8456D00C3518159EaaA839132aEE399515a617
        );
        staked[112] = IDPAIStaking.StakeMultiple(
            3853023897528820000000,
            0xBa5d9C56425Db331ba3A97dACD5031F7CDdC9542
        );
        staked[113] = IDPAIStaking.StakeMultiple(
            1799552351476570000000,
            0x097EdCe24716A50116bA4fB67F2563ad5Ce6840A
        );
        staked[114] = IDPAIStaking.StakeMultiple(
            13000907745547300000000,
            0x939826638AbbB8DD2Ea12133f3B02b2d88aA3664
        );
        staked[115] = IDPAIStaking.StakeMultiple(
            10896516582736500000000,
            0x3ba31394e167C4AC16d30BbD86d5672809c3b5Ab
        );
        staked[116] = IDPAIStaking.StakeMultiple(
            4984228815228730000000,
            0x4e7b6A10A1E3a3611039a1B834454f8a01F34326
        );
        staked[117] = IDPAIStaking.StakeMultiple(
            183232686973622000000,
            0x1633690F0C20d6b44732e5577ceceFA6F0c6ee70
        );
        staked[118] = IDPAIStaking.StakeMultiple(
            8597222930183190000000,
            0x837019D2a62C23c26a8380f88d8B8e280E092d32
        );
        staked[119] = IDPAIStaking.StakeMultiple(
            4440145434949930000000,
            0xa3E522a7dfC609dC2Eb717CDd57F2ddF0427E457
        );
        staked[120] = IDPAIStaking.StakeMultiple(
            1507682760469350000000,
            0xeE791b90b9d03c177185aa7EA5Df8Fd855d0c0D5
        );
        staked[121] = IDPAIStaking.StakeMultiple(
            6949474742687290000000,
            0x0606d8EAD64a1152D0239EEdA7343f4dE36960AD
        );
        staked[122] = IDPAIStaking.StakeMultiple(
            15593889545644400000000,
            0xC20dF7E375bc840460Fd0ce2A0544844f8BF07Ae
        );
        staked[123] = IDPAIStaking.StakeMultiple(
            10000000000000000000000000,
            0x54fc5811E34786D738b84ED05587A0088d6710c8
        );
        staked[124] = IDPAIStaking.StakeMultiple(
            73913829699555600000000,
            0xFe3Bf0dcfF794E1dF4b7bC69b620eAd6525E30A3
        );
        staked[125] = IDPAIStaking.StakeMultiple(
            125760975990244000000000,
            0x03b0E4A19F357a112BE59d658eC4E2834d510F39
        );
        staked[126] = IDPAIStaking.StakeMultiple(
            785017137858574000000,
            0xA8338D6d1F22dDF9B6d3B04cb707b3cE3F48D3F1
        );
        staked[127] = IDPAIStaking.StakeMultiple(
            1565073591523300000000000,
            0xe953ccd0731fa7936ff43Cd78984187c4A9530b2
        );
        staked[128] = IDPAIStaking.StakeMultiple(
            5043034882687310000000,
            0xc0301e7421EF4defDEF051AfC8716E6d4107E768
        );
        staked[129] = IDPAIStaking.StakeMultiple(
            15686940887875400000000,
            0x3BB7F68a5aA062Ace1f7a13f155Df901f0A55Ea2
        );
        staked[130] = IDPAIStaking.StakeMultiple(
            7387037354712480000000,
            0x0541Cfbf9d1C0569B2c90657D629eF5a1F02bd6a
        );
        staked[131] = IDPAIStaking.StakeMultiple(
            25389993484617400000000,
            0xdccbD990708fa671e52cb0BdB882fA00614B26F9
        );
        staked[132] = IDPAIStaking.StakeMultiple(
            150302608050128000000000,
            0x887241AaB7a310feA54e2d7d8fF6BE29C41c3DBA
        );
        staked[133] = IDPAIStaking.StakeMultiple(
            21080409558688000000000,
            0x68C6A7Db93752E04148D219817f38509be70A485
        );
        staked[134] = IDPAIStaking.StakeMultiple(
            307947293872259000000000,
            0x156574Ab431a5819e2a10e3933c20Ae01Af7E862
        );
        staked[135] = IDPAIStaking.StakeMultiple(
            268938843383689000000000,
            0xA0Cc6cD94Dc93aB57B48208c5D1b691401EF4DAC
        );
        staked[136] = IDPAIStaking.StakeMultiple(
            31365865984321200000000,
            0xA9B6c14ef011bc77FCdCb3d7EFa847D02d8c3209
        );
        staked[137] = IDPAIStaking.StakeMultiple(
            40000456219151600000000,
            0x3E52646c94aDEa38Ad7771A5C39DD0b883D388e4
        );
        staked[138] = IDPAIStaking.StakeMultiple(
            986106200000000000000000,
            0x960eD67301176764005232509c438C5B6d6Cf80D
        );
        staked[139] = IDPAIStaking.StakeMultiple(
            529010669546425000000,
            0xcb146736001e088eDC746B6670b511009c44e92B
        );
        staked[140] = IDPAIStaking.StakeMultiple(
            65109759046071700000000,
            0xF1F045D0993963e9890C0Dde2C4CF591ac36565c
        );
        staked[141] = IDPAIStaking.StakeMultiple(
            537989771625060000000,
            0xC9b25Db59716b8A180a63285034aC9f207c37b1e
        );
        staked[142] = IDPAIStaking.StakeMultiple(
            19713787491455800000000,
            0x27e69F5CE44a3314eb0cbC7f47A5273b7dB84145
        );
        staked[143] = IDPAIStaking.StakeMultiple(
            10293728726357700000000,
            0x34F7D64aee7F777e5CF9DBbcF84Dac39B42675f3
        );
        staked[144] = IDPAIStaking.StakeMultiple(
            113315783602069000000000,
            0xB4cF4F490cbCE8Cc6A8F008Af16997C91E2f5004
        );
        staked[145] = IDPAIStaking.StakeMultiple(
            70650603001937900000000,
            0xdE8a21E3afD13680a41b14657900ED026180cFe5
        );
        staked[146] = IDPAIStaking.StakeMultiple(
            6494832496980120000000,
            0x52642148cEd474432dE2A133CCFba4116e64CB80
        );
        staked[147] = IDPAIStaking.StakeMultiple(
            4182040249553360000000,
            0x0D62Fe3871E4A111C2F221cd17AB98fDB5e17868
        );
        staked[148] = IDPAIStaking.StakeMultiple(
            15522752564750200000000,
            0x44706534d89dA5a71cd897DE068c654Ff45c3613
        );
        staked[149] = IDPAIStaking.StakeMultiple(
            11638465082035900000000,
            0x4A74a21Bd540b051A2D73451EF805774C4FB578a
        );
        staked[150] = IDPAIStaking.StakeMultiple(
            3318224601934000000000,
            0xA79CD0917c0310BA55ea1e340084eBE587B45f6F
        );
        staked[151] = IDPAIStaking.StakeMultiple(
            3319000000000000000000,
            0x8973341afAaFc1f8013d9Da6D17F7b6876879EE2
        );
        staked[152] = IDPAIStaking.StakeMultiple(
            2281535804510170000000,
            0x39d8454bC77Fb2E2F2CCE27928ad4B4bB8b7C25a
        );
        staked[153] = IDPAIStaking.StakeMultiple(
            10000000000315300000000,
            0xD0446D7a71288660C7b78c5D6b2289E4e446b5F1
        );
        staked[154] = IDPAIStaking.StakeMultiple(
            1611265392998070000000,
            0xEB808ec712036d213284734966B33E1567d6e20A
        );
        staked[155] = IDPAIStaking.StakeMultiple(
            1313532432791830000000,
            0xBB4bC43d045e19f0f18A7747Ebc16692b04df373
        );
        staked[156] = IDPAIStaking.StakeMultiple(
            26813798658982800000000,
            0xC0e065c582DC12Cd1Ee92266293Cd3BA169876EC
        );
        staked[157] = IDPAIStaking.StakeMultiple(
            640003980359979000000,
            0x4c2B8dF45cA620aaC5D75C15b4aC2710dE22a9FC
        );
        staked[158] = IDPAIStaking.StakeMultiple(
            1533244222677630000000,
            0xaE4B831C0dd44685e6520d400D387953E6EBc5b1
        );
        staked[159] = IDPAIStaking.StakeMultiple(
            2412432325417560000000,
            0x753D2D4Dd0c70026425B651dBd86e36f8b4A087f
        );
        staked[160] = IDPAIStaking.StakeMultiple(
            19999999984521800000000,
            0xbbB41F902220C182a87ba9976131Ed03FE8380A7
        );
        staked[161] = IDPAIStaking.StakeMultiple(
            60171289404233400000000,
            0x8d99C04eDe67EF5c2936215f95Af1A11045EA298
        );
        staked[162] = IDPAIStaking.StakeMultiple(
            40000000000000000000000,
            0x723ddEE3cE1aCBd7198259062223C340604E62Ae
        );
        staked[163] = IDPAIStaking.StakeMultiple(
            287881939796500000000000,
            0xd986FC664e243E3F8220d2cbFdAF7dC67Dc407f4
        );
        staked[164] = IDPAIStaking.StakeMultiple(
            4246163128343610000000,
            0xF9c76Eab3ED958dA6eFfA4739288b30A293Aa1d5
        );
        staked[165] = IDPAIStaking.StakeMultiple(
            5150468589644230000000,
            0x3d508c91C6D760ef36a808CB8C6B9C2DB45b216b
        );
        staked[166] = IDPAIStaking.StakeMultiple(
            2668702983148930000000,
            0xF5F1D04B6b2F5f5A26670Fa02F76965e7dAEAa2f
        );
        staked[167] = IDPAIStaking.StakeMultiple(
            2028237750653650000000,
            0x6b8fc2A81E08E4A46A630B91857A4a36ea7855CE
        );
        staked[168] = IDPAIStaking.StakeMultiple(
            2004893085240390000000,
            0x39614d0AfD561935C80a6b67369EE608D9dD564b
        );
        staked[169] = IDPAIStaking.StakeMultiple(
            939804558029293000000,
            0x8f214ed50C1b2c92DA77B31ECeD2a4eD00bEAc6B
        );
        staked[170] = IDPAIStaking.StakeMultiple(
            7342248868013040000000,
            0x97CC5f68792eefF3B8897B3Bb24771280beB3aad
        );
        staked[171] = IDPAIStaking.StakeMultiple(
            61231373073347000000000,
            0x59747f07D732AcEd498Ed24817585f332A617Dc8
        );
        staked[172] = IDPAIStaking.StakeMultiple(
            1058238996316120000000,
            0x804A7130cAe113d39DaF866B430c2A211AFE7018
        );
        staked[173] = IDPAIStaking.StakeMultiple(
            175062858393663000000000,
            0x34C091aade04b03180918143B6cb033706344D77
        );
        staked[174] = IDPAIStaking.StakeMultiple(
            513601859843109000000,
            0x2419E2CE53BF882211e4A6F1c670F62767AB9b52
        );
        staked[175] = IDPAIStaking.StakeMultiple(
            417258788192929000000000,
            0x814B7539a152CEA1645494319C0ED2c56fAFfb97
        );
        staked[176] = IDPAIStaking.StakeMultiple(
            1306031321833700000000,
            0x3855fEC7cEefD87d1933D614e8003a43C2F12711
        );
        staked[177] = IDPAIStaking.StakeMultiple(
            712525823119536000000,
            0x9b849DCD1C861cd5bFEC9c13b01d130CCD8495c7
        );
        staked[178] = IDPAIStaking.StakeMultiple(
            215098930223273000000,
            0x260358a3f6f3782fBFC16Fc4C85D90D95E0d18A2
        );
        staked[179] = IDPAIStaking.StakeMultiple(
            4531260572417960000000,
            0xcc430534753fB1f7e9E6Ac82715674d008f23E6E
        );
        staked[180] = IDPAIStaking.StakeMultiple(
            60746380563533600000000,
            0x0B80a98BCD7C73613E95344cA03c268eC0F51828
        );
        staked[181] = IDPAIStaking.StakeMultiple(
            671317345976835000000,
            0x8dbd0607d8d8c7d2d73596006aDCa7eAEDd08522
        );
        staked[182] = IDPAIStaking.StakeMultiple(
            7244701170000000000000,
            0x470d83fa810c83b2f1B71402FE44F52B26D3C1C4
        );
        staked[183] = IDPAIStaking.StakeMultiple(
            12382987794826700000000,
            0xAdd5790c552046052b52028148000e75F5E90ec3
        );
        staked[184] = IDPAIStaking.StakeMultiple(
            42059732274911700000000,
            0xE632d07D61c13D13c17d2927d02123791af5940A
        );
        staked[185] = IDPAIStaking.StakeMultiple(
            7789770070011520000000,
            0x8BAAbaDAFC509492631CD897457a57A077fC365A
        );
        staked[186] = IDPAIStaking.StakeMultiple(
            6723827398464530000000,
            0x7b917616a11b5779548b311c42AfF14e780b78D4
        );
        staked[187] = IDPAIStaking.StakeMultiple(
            16552377726619400000000,
            0x727d75755232c2719496A1B67dEE51a0e3333CA7
        );
        staked[188] = IDPAIStaking.StakeMultiple(
            65292351139308500000000,
            0x3845fE014CD780ff2f7e02CC288d389A9E6a6f3d
        );
        staked[189] = IDPAIStaking.StakeMultiple(
            1323029584315460000000,
            0xc1fca2d14420f0e9EC8e9F5Cb8984531aE6F8db6
        );
        staked[190] = IDPAIStaking.StakeMultiple(
            1938104050399890000000,
            0x6FAF1BF2210Ac99565392f2d7d962EF95962D7c8
        );
        staked[191] = IDPAIStaking.StakeMultiple(
            81245561469309000000000,
            0x4F8035314B6e4c2462F0469D62D457d73BAB6a81
        );
        staked[192] = IDPAIStaking.StakeMultiple(
            12094208005030400000000,
            0xed59D0d8c73d48235F8CdA5324006A33c9ec3c68
        );
        staked[193] = IDPAIStaking.StakeMultiple(
            2727971885309430000000,
            0x236c8a5aDc984A36Fa25065d20dB407dD93Bec03
        );
        staked[194] = IDPAIStaking.StakeMultiple(
            1147200720029770000000,
            0x491100DB75c94dffAA0C55c84C19a639b1748532
        );
        staked[195] = IDPAIStaking.StakeMultiple(
            10691298106001300000000,
            0xB8358b31BCA82989D3d6611911da3be38FE242f7
        );
        staked[196] = IDPAIStaking.StakeMultiple(
            1996024594041740000000,
            0xcE4C29Be874f570e427D67E6dc55Ed78045ee92b
        );
        staked[197] = IDPAIStaking.StakeMultiple(
            17252130023835100000000,
            0x55712891FfF0DF049ae651f03d4d8bd0Eb725336
        );
        staked[198] = IDPAIStaking.StakeMultiple(
            28166733335095600000000,
            0x367d950a03d67221E1f397809381E8968bC3A055
        );
        staked[199] = IDPAIStaking.StakeMultiple(
            3383412359000000000000,
            0x0A92601C3dDe4132E29E62B3054699eFce639E01
        );

        uint256 cliff = 60 * 60 * 24 * 90 + block.timestamp;
        uint256 vest = 60 * 60 * 24 * 180;

        vm.startBroadcast(privateKey);
        IDPAIStaking(contractAddress).stake(cliff, vest, staked);

        vm.stopBroadcast();
    }
}
