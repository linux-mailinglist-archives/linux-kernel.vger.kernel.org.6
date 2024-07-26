Return-Path: <linux-kernel+bounces-263360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 572B993D4DF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBD091F24CF9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438C3749C;
	Fri, 26 Jul 2024 14:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFdMSIAt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC2FAD59;
	Fri, 26 Jul 2024 14:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722003158; cv=none; b=f0XxTqzUXBpcxxR3A1aDOgfCSIhrHDlcg9mDxOFJkdf7aKrimYYX+myS8pAUzaWqULbddvq5JLieAluDPFZ9vl6LZCRmOGvHnz5VpM3YB2jlVkxeutwIsIGmgQ6aHMBOBS8A62pNX2Cks0JMjxhou4guuOmAMr2GTGJ4WC0ThDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722003158; c=relaxed/simple;
	bh=+MXf3TVb0NUFyYI4CHnrGX/Mv/13a3g+oLik7aEL+cE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=uLfAX7XFfb2UU2J8ta/bQqzmGcOnQwlLY8FRKHCOOlDL5cZZKaUvMl7iswZ2NEjJEOB6i4TMXbUSzSGRui8sQboqsC3G6GXSX5Xp1FB/fkkjdQI5OrvulHKaWBQaXO7d3P58b1MRf1E5nxxerG4ZbD6tiTMeuNRLLQ9SzFeW9XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFdMSIAt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D01CC32786;
	Fri, 26 Jul 2024 14:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722003158;
	bh=+MXf3TVb0NUFyYI4CHnrGX/Mv/13a3g+oLik7aEL+cE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=VFdMSIAtig9tFgVfJEFAn7oe19pEpw3dXQmZBg629r9IfBsPmDfRGPkSR2sogKdD/
	 Cfj7gd35RVfiTMnj7QldJB+4JSh6f9C4gv+VBCnJzvSMEStEB/+VW+nN1tzYto7/iZ
	 gBMkfqf3q3WJlI/O08WLh61mo6MMKvqyJ87Lobqldx2uCNKuSpOh3kAryx5Ik+vtZn
	 cCC8pHBI0nlewJabbOZ7QfVFaXtE9Qxc+b1wNWmDsojsJEGpvcF7QqOAU5oyT+JPsE
	 Lk7CgWAZJjLSAVZ1OcmLGfATj8R/nXPVROs9NDff5GJb4ju51/iZD5FLxMWObiNS3K
	 XokYN2Gu/9u8A==
Date: Fri, 26 Jul 2024 07:12:36 -0700
From: Kees Cook <kees@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?ISO-8859-1?Q?Michal_Koutn=FD?= <mkoutny@suse.com>
CC: cve@kernel.org, linux-kernel@vger.kernel.org,
 linux-cve-announce@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: CVE-2024-35918: randomize_kstack: Improve entropy diffusion
User-Agent: K-9 Mail for Android
In-Reply-To: <2024072606-outlet-stuffy-259b@gregkh>
References: <2024051912-CVE-2024-35918-3fed@gregkh> <lsh7xgorp67fplqey6evmukt66tbstbjob34bwyt7wiklkqu3n@6wftjk4z7xja> <2024072606-outlet-stuffy-259b@gregkh>
Message-ID: <D4CED3E9-5E5F-4E94-AB59-3EA617213DA1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On July 26, 2024 2:54:25 AM PDT, Greg Kroah-Hartman <gregkh@linuxfoundatio=
n=2Eorg> wrote:
>On Fri, Jul 26, 2024 at 11:45:59AM +0200, Michal Koutn=C3=BD wrote:
>> Hello=2E
>>=20
>> On Sun, May 19, 2024 at 12:11:12PM GMT, Greg Kroah-Hartman <gregkh@linu=
xfoundation=2Eorg> wrote:
>> > Description
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >=20
>> > In the Linux kernel, the following vulnerability has been resolved:
>> >=20
>> > randomize_kstack: Improve entropy diffusion
>> >=20
>> > The kstack_offset variable was really only ever using the low bits fo=
r
>> > kernel stack offset entropy=2E Add a ror32() to increase bit diffusio=
n=2E
>> >=20
>> > The Linux kernel CVE team has assigned CVE-2024-35918 to this issue=
=2E
>> >=20
>> >=20
>> > Affected and fixed versions
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>> >=20
>> > 	Issue introduced in 5=2E13 with commit 39218ff4c625 and fixed in 5=
=2E15=2E155 with commit dfb2ce952143
>> > 	Issue introduced in 5=2E13 with commit 39218ff4c625 and fixed in 6=
=2E1=2E86 with commit e80b4980af26
>> > 	Issue introduced in 5=2E13 with commit 39218ff4c625 and fixed in 6=
=2E6=2E27 with commit 300a2b9c2b28
>> > 	Issue introduced in 5=2E13 with commit 39218ff4c625 and fixed in 6=
=2E8=2E6 with commit 6be74b1e21f8
>> > 	Issue introduced in 5=2E13 with commit 39218ff4c625 and fixed in 6=
=2E9 with commit 9c573cd31343
>>=20
>> The commit
>> 9c573cd313433 ("randomize_kstack: Improve entropy diffusion") v6=2E9-rc=
4~35^2
>> adds ~2 bits of entropy to stack offsets (+the diffusion, x86_64)
>>=20
>> The commit
>> 39218ff4c625d ("stack: Optionally randomize kernel stack offset each sy=
scall") v5=2E13-rc1~184^2~3
>> adds ~8 bit of entropy to stack offsets (there was none before, x86_64)
>>=20
>> Why the former commit has a CVE while the latter doesn't? (2 < 8)
>>=20
>> I'd expect both to be treated equally or even inversely=2E
>
>If you wish for a CVE to be assigned to 39218ff4c625d, we will be glad
>to do so, but it was not on our "old list" of GSD entries to backfill in
>CVE entries for, which is why it was not assigned one=2E

I don't think either need a CVE=2E 39218ff4c625d added a new security flaw=
 mitigation=2E 9c573cd313433 improved it=2E The original did what it said i=
t did, so a CVE wouldn't seem to traditionally apply=2E

If adding a new mitigation feature (or improving an old one) means we need=
 to issue CVEs against the earlier kernels, this would be a whole new class=
 of CVE=2E (Though I would certainly support it: "your kernel is vulnerable=
 because you're not using a new mitigation" is a message I've been trying t=
o communicate forever=2E)

-Kees

--=20
Kees Cook

