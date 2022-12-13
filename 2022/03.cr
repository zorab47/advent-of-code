require "spec"

class RucksackReorganziation
  @input : String

  PRIORITIES = ('a'..'z').zip(1..26).to_h
    .merge(('A'..'Z').zip(27..52).to_h)

  def initialize(input)
    @input = input
  end

  def total_priority
    @input
      .split("\n")
      .map { |sack| sack.strip }
      .map { |sack| mid = (sack.size / 2).to_i; [sack[0..mid-1], sack[mid..sack.size]] }
      .map { |comparts| comparts[0].chars & comparts[1].chars }
      .tap { |v| puts v }
      .map { |chars| PRIORITIES[chars[0]] }
      .tap { |v| puts v }
      .sum
  end

  def threesome_total_badge_pritories
    @input
      .split("\n")
      .map { |sack| sack.strip }
      .each_slice(3)
      .map { |rucksacks| rucksacks[0].chars & rucksacks[1].chars & rucksacks[2].chars }
      .tap { |v| puts v }
      .map { |chars| PRIORITIES[chars[0]] }
      .tap { |v| puts v }
      .sum
  end
end

describe RucksackReorganziation do
  it "executes day 1 demo" do
    input = <<-TXT
      vJrwpWtwJgWrhcsFMMfFFhFp
      jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
      PmmdzqPrVvPwwTWBwg
      wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
      ttgJtRGJQctTZtZT
      CrZsJsPPZsGzwwsLwLmpwMDw
    TXT

    reorg = RucksackReorganziation.new(input)
    reorg.total_priority.should eq(157)
    reorg.threesome_total_badge_pritories.should eq(70)
  end

  it "executes day 1" do
    input = <<-TXT
      ZNNvFWHqLNPZHHqPTHHnTGBhrrpjvmwfMmpfpjBjwpmw
      sbdzQgzgssgbglRtmjlwhjBlfrSrMt
      zgsCRzJbsdRVQCDbcgLGWWLnZNGVLLZMNZnq
      tvHhRtZGMvMHvfsrBBCTRbwbccRc
      qznnlpzzDppWlDpQpCrcrwnBNwTZnBTZrn
      PdVZJJqVZdllDPFtMjMgLjGMHvSgMF
      csbhhVDDvzlVDcbccGGvfRjDHCjNLRHRCLfmnZfR
      dFrStSTTmrrrHVfV
      MMgQMMTMVTdgWtwTPwSgWSgGbbppJzlplvhBlPbzhlhbzG
      FDJSTtSGhpPFDmFTZDpTFPmCBBrHqsCBhgBlqqrqrlRrHH
      dQwMtfdzVwWfwctwnfnQCHllzRrsNzrrgNlCgqsr
      fLfQnVjfwQfMdfvfnVvWDvtJPFGDpvZGbZpmbSPP
      TzzCrJcDrTDdLDCJDvGNPCFqlZWlvNvWpq
      RRHfjsQBFsjgjBQsWqGpNvZQqQlPPQPN
      VnHBnRVssnnjsSfBwbMSrrbTwJTcwSDF
      HJCgHCCFFFVGJWTlbqDdlqTDDpgl
      cZccSmLrfZcrmmzSQftdpDtTHdbQTDMQ
      NZZccrrBwZRPNNzmcLSSjJhGhVWCnsFnHBjGChsJ
      qwwwJHTHqdFDtZBFPfFBZFzM
      gVRcLnnWVgggnnnQgVWWNZtZrBfLBzZzBrMPPrZvPv
      GQgQSVRtsVnNRGSCdpmwspmbmDpHmhwd
      bhNgNfgwpbLMhCZMGQBmDm
      FrcHrSllcqcFFMGLBDQlMDTGlT
      FVSddRSJRjLwbjJPJw
      wzhhrTwwTrSsdHQjjSHnBjQj
      gRDCmVgRgMvtMfVMRBBBhWCHQQHGJHZJQZ
      NtgVgttVbMNmvsNlpcrLhLTNPw
      MCgjsfnscgjjgnGgJHHqHDgdHbGr
      QSSmRFPpRtPFQLQRmPzvBzzzDWqrqWWHJGGNrJJbdtVWHJDV
      BdSFdLQzRFlSLmQplffwncfscChhcsMj
      GfVmfnmJVnNVFhnhGmbmhpHvqjrzHZBjfvrtBHHZrwBt
      ddWQldlMdWMlQsLWTLQgMNwBrvjrZjNrwzZjswHqrv
      QQdTRcgTRPDlMQlQPQdhcNNnbJmbGpVnGchFmm
      CjjZCCZfvWZRHHhRtwhvPN
      mrnqlqMqBlSSLnBTLBwmHPPWhPPHtFRPWzwt
      rBVTrrMMSMLQBrndGcddWQbbdZfCZJ
      LFtdjHjLjLqHqstLTjFLFqNMnMhhZdDDNMVbWdDDbhnZ
      CrBpBGnzrzmczcllrphCZZWJMDWRbbZNMDMR
      GwgvzpzvrcmBrnfHjTgqTsgHjF
      rMPPZcplCZlZPwtSwhtBwCQQzB
      FvDGffLqqmQFwmmhzt
      TjJjJfHHVDVnHVgZZlQppcVscP
      hVcqHwhgwwwjHjjGWbvrbBGrsWVWGn
      CttPRpMmPDTWbWltlLBnGl
      pZmDFMmPMfnZwqqwfcqJdHgz
      bSJWhWJCbGGWJPStWTgRQwzDjgQQjsDW
      nFBBVQVrVBrNFMFZVpBBZFZrDgdTldgsRsslsljsRzTRjzns
      rMcZcHcBQPvbbHGP
      mSfmwqfmzrfHwFfmrwvPHqPmMFRlMDDZBCVVRCVZVlZpMRRR
      TWjdTWhTsssLTGsJNWhTQddjRMDMtNNBSCDBllMMBVtDMVRZ
      QhWTQcdhjThsdGbTLGjWHmffnmHwnwHrwqmmfcwS
      LmrsMQnnpfmMLllvTvqvFFzvFHNN
      WGRFVWdwZWZvCbJzcvJNzw
      VjGhDtWGSFRGjVVSFdjjDPBfspPnnMBLPLrrpMMm
      qqqCCJjtqtqCtqLZspHWBdSrWWSzzbzHFWBldb
      GhwwcwPFVDcNFRRGwwzmlBrBWvllrvSzlrcd
      DGGhQNNDhTpZZqqLQFQQ
      QfZmgQQZCCMLfNrgprdNvvdrTg
      hhttsBmBDcFRBlJshJcRrnjnTvNqpddNNqvndp
      JtsGJGtGGJJJHDbctllhZHmMwMQSPVPzHSLMPZmV
      DScSjZcNBZqjDDcLLfFtPfCfjfPvfv
      pTmRlWhdMwTLGwCf
      mRdWCVVglWrCmVHVrVCmdrbSzNcBDBqBZDNHqssscNzqNc
      sPMHGFMsrPNCPnNS
      ffJzllbzpZBllttBtfglgBTbSCVCmmrNFmmbFNvCFLLb
      cpZqpfgZZJtJqJJJfWHWhHdHWHjcdRdFHD
      ZZPfppvzMrlNBFcvFB
      shJgstJwWLVJwcrFFVFrBVNNqFFB
      HwWJdLHWWLcQgssHwwSQSQtQzCnZZMpZCmdzZCzpPzpCPRCj
      QCpLRbsCCQQLbQzCBQDQBBfTTffWtTctJVRNVtnfwtWV
      GvlqqlGlmMrdsvrhmlcTvwJtwNwTvfJfcWTW
      lMhgqGhddjqFFCzBBpbsSQpD
      JJwGJwVQQwVSsSMhQMQgHfgfTtrrfVTNgNNfrt
      dFDWCDdFppvDFmWWWnJTPllHmHlgrqrgggtH
      DzFbWjdRpbdFCjjRbnFbQBGhhQBBJZwMhScwZwJz
      HttvHpHmpJWtHmFNvlvdMSVdPMtLVCCMMMfcfL
      GjgzhGSGSSdCcRMVjMdc
      QshbnghgnGDnqsFrNSJFrsNs
      wJpjMwzjzdVbzPPVpbCHnqGnBqnsBrNCwgrC
      ftTLLDTQtLTGTGtFrgHrvqgQnrvQsCHH
      fTcFFfLSfFFcGFllcFhPJPjWWJSjSWzMWPdS
      ZjNdmjVQVZmvNNZNNZHWZmWtsJnwTpJJswpWwGqJhJqGpp
      FcRRcDblDMLRcRMLFFMDGsJnqhwpqTTJGwnsfnlp
      LRBrcLbbgLFgBbFqDvdHQvCCjNzzzVrZdV
      BdbLWrgdvgWvVJgWnDfNhVnqhCCpDpcq
      tSQPSTSGPMmlMPtQQPJGtGQRCcnqqfnRhCcChDqnCfRScf
      jTssPsjMQMmszPjlTtsJdFBFrJzrbJdHZFHdWH
      vCccctvvTTtZcgLGcZTbssbMWnpMpmLWqnNjpfPPfPjMPp
      wwBBlRBBwDDVFRhFlRhdRRVWPnnpMpffmmffrpWqVNPm
      ddhddRzHlQHFJcGsCztTgbNzST
      fJctfpVWcnfRLfrRwP
      vmmnvDQDZTNTmGGTqTMTvMqwBdLjBvRzBRrRBRLjjBPzBB
      GMnmqSTFFQqttcbcJWgsSt
      rHNfmfRsmfRGfDNcRmcmMQlLCGSnQwwPPCSnzQlSCl
      bsJTBsVhFsVpqFWFgPCwnQwBZzwQzZLlzn
      qggTTqvqgqbbTTFqVqgWqvNmmMMRdffftNfMDMmscR
      rFWQFszrwjsjFWvshPTCmLZLSTLwSLlgSP
      BQbcqVHNVqVpVpmClJgJJHSmZLJm
      qBNNNVdDMGBpDcDWsvdQsFrFnjttfj
      qGhmttmzhtMvhbrLdSHbdSHRzb
      WCBgQJJpjCQlgdHZrfPRPSRbNg
      jBTTDjlnjnJDJTQCVntcwtwMSvqcGFDhcvsh
      ZTrnTqMWWWnfrddMGJPgPLlPbw
      VvmGRVpBpNNmvNvjVjtpNpCNLLLJHHBdgLPdwsdsbLlwwlwb
      GmCVSCRVGmpCRVvttmpDrQZfhnzhzqnDWnrZZTQq
      DQBZHHtWHzSvZvDQWchgqsqqhrrhhcqrcZ
      jdMfwlFfFlTfndwpjjwGnNrqhPTmPSPTPPhmgrPSrh
      jlGbwGMdlnJpGFGjpnFCSJzzDDtWHCBBQBvtVC
      RrbBWBRRWSRsBBVvsPHZDwSjjPdnHwtPtH
      fTgfzMmNJpmJgfllgpjVQtDDndVQpdnHVtPp
      gGmlNclTGmGFhLVcVrvLqrvc
      QcpCTVCZVcCwLcCVvHvvVsCcNzNNSbPRzsDRDSBlsNNzDRtb
      fggMfJqgrWFpmjWMggmrfMWNSbRSPBDbNtJRtPJzlStBbN
      gdnmpWGnZvdQCvdv
      tqqcLqqDDqNtDrqHrrPWlTlTWZTMzTFzQlMPSZ
      pfnpmmppmppRGjwbjmnjwspWbQQQTMWZbCTSZCSQlCllZF
      gmpVnGmmmpjDvVLBFqqvrH
      LqBvJHZvbHGBHrBtGGQTmSVprVzhpVPDPQzQ
      CRdRgwCfhTVDzSdQ
      fRCcjgSMjfNgMMLGbGZtvBbGHv
      HgvtDDzDpvwgvvqdHPZWdMssTTddSs
      rJFrGNFVQmNFVmRnWhhsrTbhwhZTrdTd
      VQGBBBVNQClpcBvBwD
      PWlSzZGmdmGmlGmhggBpvMjvMjFgPJ
      TtLRDtQQfTVcQQQRtBsJFFccFjWhJJFMBs
      HqVCNtWHCDwdnlGwGqSr
      RwdRJgCJRGGmdMbcGbdnTnTtttLLnptMtMtMqZ
      DWsWPFrPqVPPLVCB
      zQWWsslsQHFhDSszDSFQzJJJmvcgblRgmNvCJmvNgw
      tpmFrWTtRpRTtggsSlnQpsnnlSHPsn
      bZwZjNNZGLSrVsGndPPV
      NvrcjCfbvvLBDBWfWFgRRm
      WWFMgWmMhhwDcMMMDcmLWLtQwwsjbsQHvZHbRjZfsZzH
      PTCplTCdSJJCpvPGNSvsbsfHtbQZzdHjQtjjsj
      vNGJPpqJvJvqghgFgWFmLD
      RlRpLTZCjWRjRWwpRsjHjbSbqMqMvvnbnGMnGGqQCq
      gddfDNczmgPthNcDdgPVnbbzbnJrJJGSSVJJQS
      BmDmcDmcmhffdBHlRwjRLpwlWQ
      prQlfzlWRPzgQWzlMPMRppssHHsDsHjwnHHbWDwwbwjL
      vFBJJtZNShJvZFtdSqtmqjTDVHVGDHbwVHDVsDnThH
      vcjBZZdZqvCfpzRfcgRp
      cggpqgRlSpNsgNggbjjj
      ZZSSJVLVLFDZWNGjCWWbCjsF
      vZLvfZQQfQtJVJDQShLrLfMmnldmwqwTqqMcMTMTndrm
      bQBMtBPddtMFbJFhRGzMfzvnRGRSvWnW
      TmHTqlVHwVpQqjmwGvSgSpnLpzfWGWSn
      TTrDQCDrrTmDCCCVHHQZBdZFPdsNdFBtFDhtFB
      fjpQvNZcGhGGTtQS
      DVJzvbVmHbbtSTSTRStzTM
      VDvmqllmJfjWlnplNs
      ZmdHZJjvQLdRjpmLJrqqZBhhtCschPfBPcrDfPffCD
      MWWSMMwnwlSgzWFFgSwzVwzqcfDCfChCbbtssbfDChcD
      NMqFTwGqMwgwwgjHRdHRjdmQmQTm
      TTqWPCWRhTWqPNjPJMNtrlbJFttQwwrBrlbwlc
      GfpSDGZvpQffSHDgggDZrHctFmrHncnnwwbBtBrt
      SQGfLsSLZsqMTRNMPT
      HdBdnBZJTZBBmsfwwBlh
      MjCVjzwqWrfzplzW
      vVbqCjjRgjwMbnbGHJScScZHLL
      dwwwtCdznvDDFrMrrw
      GmWLQmgQmHgcdGcsTgTDqDbSfFWfMDMfbSNqvr
      QhTLmVQHLmdLTjGGVptRnZpZBZVRpPpP
      CzjFpzRHdtBFBCqNqSbJZWcQJTSbQjMTWZ
      wGwVLlGrdVGwDnwsgfMSZvJMbWJcWlvbbMSc
      rDfsgggrGnGngsPwdVLfDnmDtzzFNCPHtzCtFHpBRqhPztzR
      mrgWzBcDtVCcQcCCdscf
      LRJhjRjPZvqSRGhGjLgMCdHpMNwQCpMHpHMS
      GRvGJRJjqPZbvGGhRjnqLJWtgFgtzTzDrFnTWrlTlllW
      cbmcddlffvbTfvFflpZzsMVNznNVlnqnzqHMNM
      StWJBQRWLRWNPNMCswRVHC
      BJQBhSWhjSthJQGGWWggJDDDfbdbbfHbddbrFrddvFvv
      jFqvqvWZWDtBJrrlrq
      TzGcbHcrmVzMGNSmTcGDtBthJCNtsJDlBCghgP
      bTrnTccnLSrrTHbnwfLjfdvRRwZFdwfR
      drHVrdVDfsDbVsdVDbVqRwbZZwCRCCCJlJThwRgT
      jFPcFpBSvtNPzSFcjcQpcQjpThZCRltGRRRJhwCwGhwgwhRm
      SQSzPBjjPPSvLqqssdnqLZLMsM
      bQTWlWlvQclNwwWlCCLStCRSSjStpj
      zVZZDdBnBmgzVsjsLthSpshdCL
      DfBnrmBmgzHBfDHmnGrNFCwQvTPvqCTwqTFGbF
      srSWJnrbmlWlbhzsWszSvPGwvgDhcjdjjfvhjvGv
      BRRQFLtNfQNMpqpQHDjdDjDcZZcvwZZHPH
      NLCNCtRQfRttRFRCTqMBqQQrzrbzrlJmVVbsSWmVrTbSzJ
      RHLfLcSRTFSghLRHGbwZmMZddgJswZsbMm
      ptqjtCzzQztqCjDlBGpDpbMZdwmMbZsdwNmdJpbs
      tttzCVllDCtDQnQBVHGHWvWTLWcLSLHf
      FVlNnPqbGTHftghggJqf
      zLcZWZpWWrcrZLLZDWrwMcrhBFBttChBmBgptChhtFftmf
      LZZLrDrrDDMrcwrDwsWFzdTlnGQPQQVbdbnsvnvsVQ
      BbPNMJNbQvDbvPLwHflczlwwzf
      pZjWZGZjFGdgpnVgZhghdmcflrlswzzcstlrLwhtwc
      WZSdqFjqSqSWdGFjZpdMTTDNTvLCRRLLqRQMCN
      FqgFGtbgTvRwrLqhvw
      JCCWJWCdJMQNNsSWsMPQRDDLDSDLwTrrvnwfDvnD
      HdPJlBBHCCQdBMWdTtVbgHczGVGjmtzG
      PLlZDLZDsFCvbDQv
      HVcTmVmJqVzqczfzbjvvCFMRfCsWjMvR
      cqHzTqJTTTTzzmnmrctrBlLlvSlgLdZvSwSlpw
      SbMMNJjmgMnJdSSbjVFZVSQrlQfWVQVWZh
      PtqDqPGcLHzHpqLcRzRsfQFfZlfRfZfRFVsl
      cTDLcqGCzDTqzzDLDzqPTtJvbBJMnmvjbdlmJNvmdgNC
      tDJDlZVqJGbvHNQbNFFsFPmLns
      ppczpzpffGwfBNLGmn
      WShzgTTpWzhWztJJGJSvtvvtjq
      TbZFTFScnCZFQRTCqQdBjdJqjBqjjQDB
      rmmLpLLfzrlmslMBHvdRddNDDJDrqD
      MWwLPzmWfpsMmmlMPMWLwRTZTZnnTcVCcZFCwSnZ
      SqmClqHssNWCqPTcWcGhBTchVV
      ZnnnDflRpBVTTVhPBZ
      DpgfvnvMfCsqlMtSll
      ZzLMRZpLMwwppZqnQGvQgBSvlNVlBFFNFVrg
      HcqhTmhmdDTPFTJgTTFBSgJN
      mccPdDDHbssbtwZMqpbzCRGM
      TgqnTltgWqLRSRnlqddngFfrvHvrBTfCCFrFVTvVCf
      cwNJmPzQwNzczzNsJGhhHfhrfvVHGvtvVVfC
      jjtbtDswcmPWlbgRnRdMZL
      TmpTBBwvspTptRmsmTGLQDGRHGgVGLSQSMHQ
      ZlPWqjWrzjPqdrlzbrbrwfrWLHVMLnHDMVDQnLQfQfVngQLS
      zNwbrrFWbFJpmpmvvt
      RMQQMwHMMzcFsWsDrWfcpJpS
      LLhZmGVLhVlTZfWWfWpCrDsGSp
      VLVTnqjjZngtQRFjvzDM
      gmRBpjrpRvCfRCrBgvjHShnbnngbgSJnNsHMHS
      ZDPTwGWtqwHhSnbcMNJw
      DWGGqtVVqldWZzMzWmvjrjprLRFjRVvvff
      tCzVzsVtDFzssnSsgdqJdCNqJhmgmpqq
      PZccPGvQfRLMQwNdhpwhNh
      jLrcbRjPZBrcPdjRHFlWnVtBFslSWznW
      vvvbJbWrLvFWHzZzZRhB
      chtwTmCNlRRZzRPT
      hmcCssCswrMDGMSrsr
      LStGBsQLlllhzMzs
      dzVZDNWRDdZNDTZTPvWVhhphpMlfMccRmfnlMlRn
      VFvgTrNPdFWNNFNFTzTFFSjSQBCqrtQwSBGLLBGwGL
      qGJSJhWStdSfWvSvtGRRnzRDDggrgvnzsmRP
      lTTLpcljjGlLlLNBpjwFQDQmRnrRDPrPscRrDDng
      NCNjFlHNCTVjpwGqGSVbJddqZZJM
      MbWdgvHFlMvmzTzShvmm
      tqjqpLsNsrrsjstNLpQrGVhVBzrhVcfmchDcTPVVmc
      RqwjqjqsGjjGGQNjGpQZpqRFJgmMHwdbFWgnHMFdwmmCFW
      HHHLcCcVHjTHglsB
      wDSRwzzRpMSdNSPSwSpRbqvgBsdqlgTvBFBjgFvvgB
      RpbzPssDMWwNRbRNRPDsDhJthLQVGLJcctQCJQfQJCLm
      WsZgbNgZVCCWbVVVmgZbCCRPccGnzPBqJjzWJBJPzvBvGz
      SpfThHtrHFBPPzJvPntj
      QHDhhrhpTQpHhQHnfwnTCNlbZCCDLNllZlVsNCNl
      QtzJFRQLMRnZcZsfcphlPQ
      qSBbjmWSCNmVldSqqSqmjCSZshfwfrPPZZfcPVZfhgsgPg
      HqBbHqBGSlNBbltnLLHFJMtRvRTD
      tcGtDdMcttttHNBlMctldlwjwwqqCLCwDwZjFCZhmnwC
      VrJgvWWsPvRgVgrJQvfQfzgVzZwCbLZmnmwCwZqmnhjZbnLj
      sJpffsRWWRJVWWpHltSpnMHGcMTl
      zNqRbqSbfdcTLLfS
      ZVPzPnVvdLwLDPfF
      VWnzQCVWZVMzQRHgqgqrHGtGMp
      PbHpWfWPvRfbzWPFfRpPDtBwSHMwCBgDwBjDtMMM
      hTTdZQlcnTcmqVTdcddrDgBSwsjjBgqBtsCgMD
      hlldTmdJJmJdZvzfFfNJFJgRzR
      PJWvJBbWsfLQWsLvmCqHCcNLHqHLLcwDqV
      dQztrZrdwHhptqDH
      ZrMGjgMSrdzQGQRJPvGGbm
      RmjljZChlDZBCRRvlmNSLSqMNLzwLvppwQSQ
      sTnVnPrVGsGTPddJrfgQgqLgGpMNQtgNtNzg
      sbbTfTdcJPnHbsJfHsdcmDDmmqBZlClmjBRDCZ
      CJmHLmHFFCFbHsbJsJqvqhQqLDhQZvnQDZnn
      wGwppTjdWPdgFpGcScBqNnNqNhQlDqnDlZZW
      pGcgGgTpGjFdwpSFVgSdpPjrMCMffzJzRzztRfHCRsVmtbsz
      CgBClZfCflPflNZRvfQswwmwmwQsQhgppdhm
      qbzDGrjLLNLDHDqtJmmhhmQdhwpQhhbp
      NLGqVqjDjjGrMFrvFWPBRBZnCvfFnT
      tbrrHsgsVmmmbtgwVsQRqjJMmqMjQfJfLFLD
      ZvlBGzdvjGfRFJQJ
      dBppnnBBhdzZncBPlznpnNdWHSsbWthbSCgHrVfgSSwVgr
      VRvMtRVFHQLvMRQFQtBctrthshTTgCmhTrgWhWZsZZ
      lzJlGBSPPhzjgZsTCr
      wJlpJPfDSpwBnddqJDdpPpcvMFHFMvNbvnNMFHHRVVbR
      CPShbbdlGCdQqlRPGPdlDWDFzjtFjggCDJgWczfF
      mrHrTrrBMBsmNsrwsBpnfpggDDcjjDDpjzFJzzjtJz
      BvsNvBLHrrrNvwBTNNsNGbdQhlPGGfqhhRGqLGdl
      PSSlPtlStGhPNMtwPMPJzDddnbnDNTDDnJqjbz
      FFVHRwVLvFvVrVHrZcLmRHggjDmdDnDnznnznzQjzdmJddbn
      WrvgRgcRcRrrcRvgcVrHVrwCCSfsCsGsllhMSSSSMttlSCpG
      hBPJqVZTqqPSlGlfddfddZvl
      JWWMJCpnMrmztzdjnzld
      RbWsrwMrpbRspbWgpwhLJPccNVqLLPSVgVPV
      hcTrWqcfhwGfWrWMjHjGvDHPmJMDzF
      ZtlsnZZtLBSbSssnbndjDJJFHFHJPHPsHMTHHM
      ntRZtSbtZgZStTqchwQfRwNpcq
      GfLqrsqQGgPgjjQGVcNvTpTpNFcWPvPPpT
      bRnRLnMZFdCMcpvT
      RnRhzRlmlhhHhhmhRsqLrfzrGVSrGBSGrL
      fbMffwdZsncrGcfG
      qDBjSSLqhLBSmDbjqNhqTLjCGrCHGrvcGWcpWcrGWnCrpm
      STLDqbhTLqNTNSRhlwZlJlRQFFRwMdPQ
      TVVGNFggcjPPJzwvQlRRwRvSlcSc
      frsBbWhtSRzSLfRf
      qDCqddbsWrqzhsdNmdJNJHjTggFFVV
      NTWTDrSdFTLtPTGf
      lZqjHlVRvRltLtRWFMtFLL
      qvjWzzvVbZpjqllggscdchwDrCphwsdhrD
    TXT

    reorg = RucksackReorganziation.new(input)
    reorg.total_priority.should eq(7878)
    reorg.threesome_total_badge_pritories.should eq(2760)
  end
end
