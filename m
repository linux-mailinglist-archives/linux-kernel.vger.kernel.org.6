Return-Path: <linux-kernel+bounces-305186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6278962AA7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27D691F22A36
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4BA1A01C6;
	Wed, 28 Aug 2024 14:45:52 +0000 (UTC)
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4C4184528
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724856351; cv=none; b=OCpif08ir8+e7M0w2SR0fg4JkrTlNbo4AkyAlKj3uUAL5fKeau2hHdC1cpc+W4Arl7TyTe9nxjJz1wxwpeiGatDWEW1gOUiVrICMobCSSfmhZekJsNnNPP/J3XWmhVbjONqd7yCEdRSm1I4w3s/kTczwEHgy+MX1NrQb37cuG+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724856351; c=relaxed/simple;
	bh=OohwAWyKF0rEJoxdf2Uc5m1qShP7B4H33VP7hQy0yso=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=hslBfxV5g63t+LmCeX1K+kTfdK4jhmzq4lePB8MVMhLC30YH8hmwZ3ca5/bJnhfTuCiPZw9Up5crm6GA7vadrMBDrffdcFn455w6YgfDceEoQ9KJX2jg5LcZWuLyZudg3Xq5vE8Lm+9pItaKLs8ISj0EcSCo2MI2BGgXJ1j4qfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:35780)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sjImy-002eM1-Lr; Wed, 28 Aug 2024 07:32:44 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:43674 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sjImx-007Ewp-HU; Wed, 28 Aug 2024 07:32:44 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Theodore Dubois <tblodt@icloud.com>
Cc: linux-kernel@vger.kernel.org,  Ryan Houdek <sonicadvance1@gmail.com>,
  "Guilherme G. Piccoli" <gpiccoli@igalia.com>,  David Hildenbrand
 <david@redhat.com>,  Kees Cook <keescook@chromium.org>
References: <20240827215930.24703-1-tblodt@icloud.com>
Date: Wed, 28 Aug 2024 08:32:20 -0500
In-Reply-To: <20240827215930.24703-1-tblodt@icloud.com> (Theodore Dubois's
	message of "Tue, 27 Aug 2024 21:59:30 +0000")
Message-ID: <87ed68wz6j.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sjImx-007Ewp-HU;;;mid=<87ed68wz6j.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19FmAXIn7xhpqXgAi0nUvZr+J5CSYV5c1M=
X-SA-Exim-Connect-IP: 68.227.165.127
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: ****
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.5 XMGappySubj_01 Very gappy subject
	*  1.0 XMGappySubj_02 Gappier still
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
	*  1.0 T_XMDrugObfuBody_08 obfuscated drug references
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  1.0 XMSubMetaSx_00 1+ Sexy Words
	*  0.0 XM_B_AI_SPAM_COMBINATION Email matches multiple AI-related
	*      patterns
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Theodore Dubois <tblodt@icloud.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 552 ms - load_scoreonly_sql: 0.17 (0.0%),
	signal_user_changed: 14 (2.5%), b_tie_ro: 11 (2.0%), parse: 1.24
	(0.2%), extract_message_metadata: 26 (4.6%), get_uri_detail_list: 4.0
	(0.7%), tests_pri_-2000: 38 (6.9%), tests_pri_-1000: 2.6 (0.5%),
	tests_pri_-950: 1.44 (0.3%), tests_pri_-900: 1.25 (0.2%),
	tests_pri_-90: 116 (21.1%), check_bayes: 112 (20.3%), b_tokenize: 11
	(2.1%), b_tok_get_all: 13 (2.4%), b_comp_prob: 6 (1.0%),
	b_tok_touch_all: 74 (13.4%), b_finish: 1.75 (0.3%), tests_pri_0: 335
	(60.6%), check_dkim_signature: 0.60 (0.1%), check_dkim_adsp: 3.9
	(0.7%), poll_dns_idle: 1.65 (0.3%), tests_pri_10: 2.4 (0.4%),
	tests_pri_500: 11 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] prctl: allow prctl_set_mm_exe_file without unmapping
 old exe
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)


Theodore Dubois <tblodt@icloud.com> writes:

> As far as I can tell, the original purpose of this check was simply as
> the easiest way to work with a quirk of /proc/self/exe at the time. From
> the original patch[1]:
>
>     Note it allows to change /proc/$pid/exe iif there
>     are no VM_EXECUTABLE vmas present for current process,
>     simply because this feature is a special to C/R
>     and mm::num_exe_file_vmas become meaningless after
>     that.
>
> num_exe_file_vmas was created to preserve a quirk of the original
> /proc/self/exe implementation: if you unmapped all executable VMAs,
> /proc/self/exe would disappear (because it worked by scanning the
> address space for the first executable VMA.) Keeping the quirk after
> switching to just saving the executable on the mm worked by keeping a
> count of executable VMAs in num_exe_file_vmas, and zeroing exe_file when
> it reached zero. You can probably see how it would have been annoying to
> handle both num_exe_file_vmas and this prctl intending to change
> exe_file, and it's easier to only allow changing exe_file after
> num_exe_file_vmas has already gone to 0 and made exe_file null.
>
> However, num_exe_file_vmas no longer exists[2]. This quirk was taken out
> because it would save a bit in the vma flags, and it seems clear by now
> that nobody was relying on it. These days you can simply update exe_file
> with no interference.
>
> Recently a use case for this prctl has come up outside of
> checkpoint/restore, namely binfmt_misc based emulators such as FEX[3].
> Any program that uses /proc/self/exe will, of course, expect it to point
> to its own executable. But when executed through binfmt_misc, it will be
> the emulator, resulting in compatibility issues. Emulators currently
> have to attempting to intercept syscalls targeting /proc/self/exe to
> redirect the path, and this is not possible in the general case
> considering how flexible path resolution is. For more detail on this see
> [3].
>
> The above seems to me like a solid case for simply dropping the check.
> It's also worth noting that it is already possible to achieve the same
> result by the laborious and complex process of just unmapping all your
> code and remapping it again after the switch (just remember to put the
> code that does this in a .so!), so this is not strictly allowing
> anything that wasn't allowed before. It's just cutting red tape.

One of my original concerns is that allowing changing the /proc/self/exe
has the potential to make /proc/self/exe unreliable and specifically it
has the potential for a rouge program to hide itself by setting a false
/proc/self/exe.

That is part of the reason for the red tape.

Maybe I am wrong but I am concerned that your change may be making it
too easy to change /proc/self/exe, and would too easily allow setting a
false /proc/self/exe.

So it may make better sense to have a special case for interpreters,
so we don't have to worry about people setting a false /proc/self/exe.

Looking at the code I am a bit perplexed at the moment as I don't see
a check currently to ensure the new exe_file is actually mapped.

...

Beyond that your change reduces replace_mm_exe_file to set_mm_exe_file
so it would probably make sense to combine the two of them if you
are going to go this far.

Eric


> [1]: https://lore.kernel.org/lkml/20120316210343.925446961@openvz.org/
> [2]: https://lore.kernel.org/lkml/20120731104230.20515.72416.stgit@zurg/
> [3]: https://lore.kernel.org/lkml/CABnRqDdzqfB1_ixd-2JnfSocKvXNM+9ivM1hhd1C=ejLQyen8g@mail.gmail.com/
>
> Signed-off-by: Theodore Dubois <tblodt@icloud.com>
> Cc: Ryan Houdek <sonicadvance1@gmail.com>
> Cc: Guilherme G. Piccoli <gpiccoli@igalia.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>  kernel/fork.c | 22 ----------------------
>  1 file changed, 22 deletions(-)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index cc760491f..407e515b9 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1430,30 +1430,8 @@ int set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
>   */
>  int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
>  {
> -	struct vm_area_struct *vma;
> -	struct file *old_exe_file;
>  	int ret = 0;
>  
> -	/* Forbid mm->exe_file change if old file still mapped. */
> -	old_exe_file = get_mm_exe_file(mm);
> -	if (old_exe_file) {
> -		VMA_ITERATOR(vmi, mm, 0);
> -		mmap_read_lock(mm);
> -		for_each_vma(vmi, vma) {
> -			if (!vma->vm_file)
> -				continue;
> -			if (path_equal(&vma->vm_file->f_path,
> -				       &old_exe_file->f_path)) {
> -				ret = -EBUSY;
> -				break;
> -			}
> -		}
> -		mmap_read_unlock(mm);
> -		fput(old_exe_file);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	get_file(new_exe_file);
>  
>  	/* set the new file */

