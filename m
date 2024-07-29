Return-Path: <linux-kernel+bounces-265364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FCB93F00E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64F831F210A5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE46413D291;
	Mon, 29 Jul 2024 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="uqjOXaVM"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BF513CA95;
	Mon, 29 Jul 2024 08:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722242678; cv=none; b=Xq1oUQzexPGnduNETeV/06y6ApS5gRvJNmkWlN2uotz91Uixr+6vPsM1hjjyGbvUIURtSNYVxoneyXp9HrBxsKgzwfaAb/R/Y+Lz9dZd+MOajYTwn8B6BZlgLT9IFllk/4fGNJphN0S4q8s9cYOKEKMrQUZxmjdYa09yGBh6sL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722242678; c=relaxed/simple;
	bh=sUzxl/I0BxPm2sNMAsakjMuhdwuD8G3WNcAs5INaddY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=l65TbMfw/QD+QgUB+GzOem4y1ylvQape6jT9cJlgIfx3csRk5R+lI/1aLiujt1ILqDokssLDBb0W59/9ZwpOKKolP34mtUZfm3tBbmO/fLCDAcEi7rQ97Yw7tioZV6wytnHBzTcMauErgB2kJBABiFoWALzWLqZlNB3/Dj+bEYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=uqjOXaVM; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Cc:From:References:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=qvmM1LnMtxEgPpQ4kkzr+8JDGpi0m4C+JZPiDrVi5IM=;
	t=1722242676; x=1722674676; b=uqjOXaVMt4IKSPHr52LWuDaojG7W8tqELrrXnFbGgAh3KnA
	JH1lkybm7MNzIkicBUujeUFZ3b9ijSSOM2CwIi1UEflBKaKt2HELoVUWWMRqq5oqRhno2LCat5Rtf
	tyfFY42kg0M+VcM3Zp/uGx641uN8BYELPFQkmTYxbm6V5IF+GlWFj/jmdFqX0xsmP+I3YFfMLIl7h
	KCej49TQmtRk/5953sUVP/0wf+OAc4lNenJiaZHvCT3EZ4BXttupjHkQ6e5AqRaBwXiKg5uEYwans
	KIgSi5csEqrS3WTCb5rJbtc9pF5L9bhW+VacQ2q7ISsSejMGAIZxRY/o2Q/BWpYw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sYLzd-0006iU-LI; Mon, 29 Jul 2024 10:44:33 +0200
Message-ID: <1d5d764b-65a4-42a2-8cc7-37d558aab381@leemhuis.info>
Date: Mon, 29 Jul 2024 10:44:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: ntfs3: Folders mounted with 555 permissions?
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
References: <edcd6eb8-8682-6552-a5f6-584ac103d0e9@gmail.com>
 <05b8cdbf-6ca7-40b8-9292-f332e1ad3a84@gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Cc: Julian Sikorski <belegdol@gmail.com>, ntfs3@lists.linux.dev,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
In-Reply-To: <05b8cdbf-6ca7-40b8-9292-f332e1ad3a84@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1722242676;0ed11e12;
X-HE-SMSGID: 1sYLzd-0006iU-LI

Top-posting: adding Konstantin to the list of recipients, he might have
missed this on the list.

Side note: this seems to be a regression, but given that it seems only
few people care and apparently is caused by the removal of a feature not
working properly beforehand, I don't think this is something covered by
the no regressions" rule.

Ciao, Thorsten

On 27.07.24 22:34, Julian Sikorski wrote:
> Am 11.07.23 um 10:04 schrieb Julian Sikorski:
>>
>> with linux-6.4, now that noacsrules option is gone, an old issue has
>> become problematic. When I mount my windows drive, some of the folders
>> in Users are mounted with 555 permissions, including the ones I would
>> like to edit:
>>
>> $ ls -l /mnt/windows/ | grep Users
>> lrwxrwxrwx. 1 julas julas          8  1. Dez 2018  Documents and
>> Settings -> ./Users
>> lrwxrwxrwx. 1 julas julas          8  9. Okt 2022  Dokumente und
>> Einstellungen -> ./Users
>> dr-xr-xr-x. 1 julas julas       4096  9. Okt 2022  Users
>>
>> $ ls -l /mnt/windows/Users/beleg/ | grep Documents
>> dr-xr-xr-x. 1 julas julas    8192  7. Jul 15:28 Documents
>> lrwxrwxrwx. 1 julas julas      24  9. Okt 2022  Eigene Dateien ->
>> ./../../Users/beleg/Documents
>> lrwxrwxrwx. 1 julas julas      24  1. Nov 2021  Moje dokumenty ->
>> ./../../Users/beleg/Documents
>>
>> Is this intended behaviour? It appears to be quite an old issue [1].
>> If so, is there any other fix than running a recursive chmod?
>>
>> Best regards,
>> Julian
>>
>> [1]
>> https://www.reddit.com/r/archlinux/comments/r325t3/permissions_problems_with_the_new_ntfs3_driver/
> 
> One year later the issue is still there with kernel 6.9.11:
> 
> $ ls -lh /mnt/windows/Users/beleg/
> insgesamt 18M
> dr-xr-xr-x. 1 julas julas    0 19. Jul 2020  '3D Objects'
> -rwxr-xr-x. 1 julas julas  77K 20. Nov 2022   AMDRM_Install.log
> -rwxr-xr-x. 1 julas julas 2,7M 20. Nov 2022   AMD_RyzenMaster.log
> drwxr-xr-x. 1 julas julas    0  2. Dez 2018   ansel
> lrwxrwxrwx. 1 julas julas   30  9. Okt 2022   Anwendungsdaten ->
> ./../../Users/beleg/AppData/Roaming
> drwxr-xr-x. 1 julas julas    0  9. Okt 2022   AppData
> -rwxr-xr-x. 1 julas julas 1,4K 18. Feb 15:30  aqtinstall.log
> dr-xr-xr-x. 1 julas julas    0  9. Okt 2022   Contacts
> lrwxrwxrwx. 1 julas julas   58  9. Okt 2022   Cookies ->
> ./../../Users/beleg/AppData/Local/Microsoft/Windows/INetCookies
> lrwxrwxrwx. 1 julas julas   30  1. Nov 2021  'Dane aplikacji' ->
> ./../../Users/beleg/AppData/Roaming
> dr-xr-xr-x. 1 julas julas 4,0K 15. Mai 20:41  Desktop
> dr-xr-xr-x. 1 julas julas 8,0K  5. Jul 22:43  Documents
> 
> Here are the mount options:
> /dev/nvme0n1p4 on /mnt/windows type ntfs3
> (rw,relatime,uid=1000,gid=1000,iocharset=utf8)
> 
> It is the main issue preventing me from switching away from ntfs-3g. Can
> I somehow investigate this further to help fixing this?
> 
> Best regards,
> Julian
> 

