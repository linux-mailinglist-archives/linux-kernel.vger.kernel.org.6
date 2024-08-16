Return-Path: <linux-kernel+bounces-289685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DDB9549A3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018A11C240DA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297701B5801;
	Fri, 16 Aug 2024 12:55:31 +0000 (UTC)
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46491B3F0B
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723812930; cv=none; b=nWYXoYBp9+TwR/I4ZFZg3mizvOSMoCRLBdnT6dxapavttDnngMeKkGzsTU4VgHA2BEO+ykoWfNGt1SRUiKsbeL4XJBARMGttnYGaOWj5woa8JwUiPNvQn+L1LSHy/usYoRARJhXGcUrVRKB0bVlXppyfRV3iqCjWANZi7hKP/cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723812930; c=relaxed/simple;
	bh=tLSriVxKBbwfEJhdBUpD/GnpVIoRoWGnwHu4L7xVZs8=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=BG8HyCJcoh5Tgjy7kLPaNOZm54RzXyw2XUStcjCzEQ/+gotLg9irGJ9uWd+p1XrnVqx8ba6pnHsA07UaW4Ye1W1j5RUVjnwJQg2CmDGgfq/7prA7QG/bQuR3VwQis4UYkP9psiDwj1iFwt85XPinQGWF9xEYUNHD0RsBqRf7/LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:33400)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sewUC-008RFg-8Z; Fri, 16 Aug 2024 06:55:20 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:48330 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sewUA-00EE99-W5; Fri, 16 Aug 2024 06:55:19 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Petr Tesarik <petr.tesarik@suse.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,  Hari Bathini
 <hbathini@linux.ibm.com>,  Baoquan He <bhe@redhat.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Eric DeVolder <eric.devolder@oracle.com>,
  kexec@lists.infradead.org (open list:KEXEC),
  linux-kernel@vger.kernel.org (open list),  Petr Tesarik
 <ptesarik@suse.com>,  stable@kernel.org
References: <20240805150750.170739-1-petr.tesarik@suse.com>
Date: Fri, 16 Aug 2024 07:54:52 -0500
In-Reply-To: <20240805150750.170739-1-petr.tesarik@suse.com> (Petr Tesarik's
	message of "Mon, 5 Aug 2024 17:07:50 +0200")
Message-ID: <871q2oy6eb.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sewUA-00EE99-W5;;;mid=<871q2oy6eb.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18Vf6nPdb92wzdBhT3kwrfv72NqUKEluUY=
X-SA-Exim-Connect-IP: 68.227.165.127
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: **
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4883]
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Petr Tesarik <petr.tesarik@suse.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 366 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 4.6 (1.2%), b_tie_ro: 3.2 (0.9%), parse: 0.95
	(0.3%), extract_message_metadata: 11 (3.0%), get_uri_detail_list: 1.60
	(0.4%), tests_pri_-2000: 10 (2.6%), tests_pri_-1000: 1.98 (0.5%),
	tests_pri_-950: 0.96 (0.3%), tests_pri_-900: 0.77 (0.2%),
	tests_pri_-90: 82 (22.3%), check_bayes: 80 (22.0%), b_tokenize: 5
	(1.4%), b_tok_get_all: 6 (1.7%), b_comp_prob: 1.52 (0.4%),
	b_tok_touch_all: 65 (17.7%), b_finish: 0.75 (0.2%), tests_pri_0: 241
	(66.0%), check_dkim_signature: 0.58 (0.2%), check_dkim_adsp: 3.1
	(0.9%), poll_dns_idle: 0.84 (0.2%), tests_pri_10: 2.4 (0.7%),
	tests_pri_500: 8 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/1] kexec_file: fix elfcorehdr digest exclusion when
 CONFIG_CRASH_HOTPLUG=y
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)

Petr Tesarik <petr.tesarik@suse.com> writes:

> From: Petr Tesarik <ptesarik@suse.com>
>
> Fix the condition to exclude the elfcorehdr segment from the SHA digest
> calculation.
>
> The j iterator is an index into the output sha_regions[] array, not into
> the input image->segment[] array. Once it reaches image->elfcorehdr_index,
> all subsequent segments are excluded. Besides, if the purgatory segment
> precedes the elfcorehdr segment, the elfcorehdr may be wrongly included in
> the calculation.

I would rather make CONFIG_CRASH_HOTPLUG depend on broken.

The hash is supposed to include everything we depend upon so when
a borken machine corrupts something we can detect that corruption
and not attempt to take a crash dump.

The elfcorehdr is definitely something that needs to be part of the
hash.

So please go back to the drawing board and find a way to include the
program header in the hash even with CONFIG_CRASH_HOTPLUG.


Eric


> Fixes: f7cc804a9fd4 ("kexec: exclude elfcorehdr from the segment digest")
> Cc: stable@kernel.org
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> ---
>  kernel/kexec_file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 3d64290d24c9..3eedb8c226ad 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -752,7 +752,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  
>  #ifdef CONFIG_CRASH_HOTPLUG
>  		/* Exclude elfcorehdr segment to allow future changes via hotplug */
> -		if (j == image->elfcorehdr_index)
> +		if (i == image->elfcorehdr_index)
>  			continue;
>  #endif

