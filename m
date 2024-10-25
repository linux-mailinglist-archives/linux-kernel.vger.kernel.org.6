Return-Path: <linux-kernel+bounces-381200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7746A9AFBDD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E751F2449B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88A11CB9ED;
	Fri, 25 Oct 2024 08:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="Jh7veACk";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="E7JDPiYC"
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCAD1CACE8
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843348; cv=none; b=FPrGJOqnSSqgVyd7ft6JHy34mvXiOivB2pCg+Y7jrheav3+l/fhO9eQTT8avy52ucqA2GefYXzcQwSNT5bTu24fal54WGzgOWkh7Cdb1fTHL6xwo1oKIb/BXnBx1omQGBGQScROaNuzLitcEIMKLKCUtTAGtOE12NESNappodHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843348; c=relaxed/simple;
	bh=eFhDUENnS8zGkZbRU4y5LCpVMnWoZuLkbJIlmtBmFSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKWvquaUzBt3r6aIX/M9CyeAftRp++vhFKM7nUfs+sT6BYTP7VYmyXCwDpJoxodB9XCtLAUXxUiwM/ppXq0BXiX2I9hwWCeCkkQT5dc4YnI6uqLsCrrXluCah3nYjR3rSAKCG+6hj76vkAs0JWwRS9klyUcB3gQpwObU27eU76I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=Jh7veACk reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=E7JDPiYC; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1729844245; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=GvO/Y+A5F9D+Z7v2M3j3RiYz27Q9b0KXTCFNKhL41cQ=; b=Jh7veACkWTm2jvXgp7MR6IbPi2
	ih7Gw977JlYYkp11YVz/ZFfTfjohdvXgwh7W25JNPOnzrObXaXG+IcylCTUggNtZ2Hniba3Dln+qC
	qGGAn38MYdQjMO1D0z0H8pFo6Bu05lb62HX62TY2mEZCekrumv/rh9gRulUpiayhQAUSlxrgvzTus
	VCvegVfuLMPN35/Szbvm0CkPaccZ9YprchKs7JKMrlZ7eMlny4pdNgSmNXrumjXt7lgyoD+55CvYC
	M0ley4nm4ncpGcJOqojFRAm/ZHtk++P/tecX8HL8L+CV/aDO4b3aMRXSHipNn2QZAa1npisnQjopU
	7rBAJ2Sg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1729843345; h=from : subject
 : to : message-id : date;
 bh=GvO/Y+A5F9D+Z7v2M3j3RiYz27Q9b0KXTCFNKhL41cQ=;
 b=E7JDPiYCi9zSvxEIQw8H8BfGuDwv7gy7T7lNrjCM9tQGW9A1JM8p0Xbk5dzWXoI6xu7vF
 FVxCgMTcGgIuRPzgIHu3JGoJ1Ymxt7G+YXLy0KeCjFlNZ1PHZqFZX7ZNffuqJy/Gx7nwjhv
 YJ5yrgGeJnoAoAgpkYMTn8pfIKIltB1D3qfdQLf9MwA/zDwewdZkUZAE6Z0xe9WravZujKz
 nUQeCALqDIDf6QL4n8d7QyMe0JAUBebMK29ba8IXtqO7UlJ7XhHWWHDh8B9IXQYjzGTsVzK
 I8l1lZP1boYy7Xr+Ek/iokVk0gO3yMMxI/wfbZ1O9m3H3OlFN+Dn1AxQC6mw==
Received: from [10.172.233.58] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1t4FGg-TRjzcT-EX; Fri, 25 Oct 2024 08:01:58 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1t4FGg-FnQW0hQ1BVS-kG4P; Fri, 25 Oct 2024 08:01:58 +0000
Date: Fri, 25 Oct 2024 10:01:52 +0200
From: Remi Pommarel <repk@triplefau.lt>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, ath10k@lists.infradead.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 lkp@intel.com, oe-kbuild-all@lists.linux.dev,
 Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Cedric Veilleux <veilleux.cedric@gmail.com>,
 Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Subject: Re: [PATCH v2 2/2] wifi: ath10k: Flush only requested txq in
 ath10k_flush()
Message-ID: <ZxtQcCZlQOfqkTEa@pilgrim>
References: <0f55986ebe34f2b5aa4ccbcb0bed445324099fbd.1729586267.git.repk@triplefau.lt>
 <60d579e2-5eb7-4239-9a23-95fa4b32f351@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60d579e2-5eb7-4239-9a23-95fa4b32f351@stanley.mountain>
X-Smtpcorp-Track: WbEqxNCPEWl2.5waV-OtHvPrr.AnqRfguGzfy
Feedback-ID: 510616m:510616apGKSTK:510616sqkavGCBqD
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Hi,

On Fri, Oct 25, 2024 at 10:44:09AM +0300, Dan Carpenter wrote:
> Hi Remi,
> 
> kernel test robot noticed the following build warnings:
> 
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Remi-Pommarel/wifi-ath10k-Implement-ieee80211-flush_sta-callback/20241022-172038
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git ath-next
> patch link:    https://lore.kernel.org/r/0f55986ebe34f2b5aa4ccbcb0bed445324099fbd.1729586267.git.repk%40triplefau.lt
> patch subject: [PATCH v2 2/2] wifi: ath10k: Flush only requested txq in ath10k_flush()
> config: parisc-randconfig-r071-20241024 (https://download.01.org/0day-ci/archive/20241025/202410251152.A5axJliR-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 14.1.0
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202410251152.A5axJliR-lkp@intel.com/
> 
> New smatch warnings:
> drivers/net/wireless/ath/ath10k/mac.c:8076 _ath10k_mac_wait_tx_complete() error: uninitialized symbol 'empty'.
> 
> vim +/empty +8076 drivers/net/wireless/ath/ath10k/mac.c
> 
> c4f7022f0ef0aa Remi Pommarel     2024-10-22  8062  static void _ath10k_mac_wait_tx_complete(struct ath10k *ar,
> c4f7022f0ef0aa Remi Pommarel     2024-10-22  8063  					 unsigned long queues)
> 5e3dd157d7e70f Kalle Valo        2013-06-12  8064  {
> affd321733eebc Michal Kazior     2013-07-16  8065  	bool skip;
> d4298a3a8c92a1 Nicholas Mc Guire 2015-06-15  8066  	long time_left;
> c4f7022f0ef0aa Remi Pommarel     2024-10-22  8067  	unsigned int q;
> 5e3dd157d7e70f Kalle Valo        2013-06-12  8068  
> 5e3dd157d7e70f Kalle Valo        2013-06-12  8069  	/* mac80211 doesn't care if we really xmit queued frames or not
> d6dfe25c8bb200 Marcin Rokicki    2017-02-20  8070  	 * we'll collect those frames either way if we stop/delete vdevs
> d6dfe25c8bb200 Marcin Rokicki    2017-02-20  8071  	 */
> 548db54cc1890b Michal Kazior     2013-07-05  8072  
> affd321733eebc Michal Kazior     2013-07-16  8073  	if (ar->state == ATH10K_STATE_WEDGED)
> 828853ac58265c Wen Gong          2018-08-28  8074  		return;
> affd321733eebc Michal Kazior     2013-07-16  8075  
> d4298a3a8c92a1 Nicholas Mc Guire 2015-06-15 @8076  	time_left = wait_event_timeout(ar->htt.empty_tx_wq, ({
> 5e3dd157d7e70f Kalle Valo        2013-06-12  8077  			bool empty;
> affd321733eebc Michal Kazior     2013-07-16  8078  
> edb8236df4d042 Michal Kazior     2013-07-05  8079  			spin_lock_bh(&ar->htt.tx_lock);
> c4f7022f0ef0aa Remi Pommarel     2024-10-22  8080  			for_each_set_bit(q, &queues, ar->hw->queues) {
> 
> Smatch is concerned that there might not be any set bits.  (You know that the
> compiler is automatically going to ininitialize empty to false so it costs
> nothing to initialize it to false explicitly and silence this warning).

Actually I think empty should be true here, if there is no queue to
wait for being drained then no need to wait at all. Will send a v3
with that fixed.

Thanks for the report and the analysis.

-- 
Remi

