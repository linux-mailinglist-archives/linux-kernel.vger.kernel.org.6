Return-Path: <linux-kernel+bounces-357040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB62F996ABE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29CBAB27DDC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81991990B7;
	Wed,  9 Oct 2024 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bUbVY4G7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9KTLBrSy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67447194AE2
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 12:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478151; cv=none; b=pjEym0T1XSdS+a0LFOmqtgoKnryAChr8FQ8vaaaMsdmUP8VRC8Y0FFBUFcp1p5iB2uXB5740TIPD1ASG6aujeAY4TbFqoQyEFXb8Yptn66ZEfM7YiMabHuUKNshH1EsmyntkrQPd0NxqYsormtfHBOwDikpUA4RD8IMUflM/JCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478151; c=relaxed/simple;
	bh=P7VYDUqBQkmBzN8wvEbVwfWdzHJC3K3Sn2lPDFgt9ik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=poLyjeMpHcDrK5Tql7ICc58b61Y1r/6dUTTGSwu1wX64olWwIlLXw9F24g2KQuZFP4HrXyLB1mCRuiBoUmQ75DOSgqFZ1X/YCIVsKjHXrQaifhRxA82cyCT/1b13PmEbO+u2ufQoqJueLOfCVHDskL1zqD19hQz3IQOB6OML1ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bUbVY4G7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9KTLBrSy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 9 Oct 2024 14:49:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728478147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0sgPMJhOW6eJMRrZ4pHVDQ9X2cnNDYkKj8bcVLLLuY=;
	b=bUbVY4G7mSoj4ksrm91PeIb2PL+BQfiWG2VDmq381RERbWIKjUCIi3h2TzXDcKKbPmRg30
	ENTe4LAMnMDr0edKlWBVtyEjrb3mdfR/woi9uWVKwjdtE/QXLOwFF23EH8aikJYuhkx3BH
	tnZBufSoG8UPDN/jizyfuc+qdlrjJInisz1c3Lj3r2nUT7PwMD3QyBfFvi/Fl8EPkACPFV
	PH6V+8CD2wN40UvsTehdEEE7wbMcBd6h4IR8gWBL3jdeyQeKDbedEh7xIdOh2Q4CZk+pP0
	0HUkCzgIC+E98VMKFt1K+dIC51BHTCCyVK7ZfqukYCkdoY5Ajty7XLZBO2ICOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728478147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0sgPMJhOW6eJMRrZ4pHVDQ9X2cnNDYkKj8bcVLLLuY=;
	b=9KTLBrSylq9Agd5Jwops+y4ewA1GSn2oYc5hCZZ2pJU8OBQCtqqTOXw8u6+wEgc+eb59qf
	uxJzDme1S5viCWDA==
From: Benedikt Spranger <b.spranger@linutronix.de>
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: Richard Weinberger <richard@nod.at>, linux-kernel
 <linux-kernel@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH 1/1] ubifs: Try to recover from missing znode
Message-ID: <20241009144900.367f9cb4@mitra>
In-Reply-To: <351bdd98-98ac-036f-4685-56e88a102cf3@huawei.com>
References: <20241008133342.1937674-1-b.spranger@linutronix.de>
	<0840be30-63bc-449d-a9a4-c4e6b54c8885@huawei.com>
	<883601802.30668.1728453832223.JavaMail.zimbra@nod.at>
	<351bdd98-98ac-036f-4685-56e88a102cf3@huawei.com>
Organization: Linutronix GmbH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Oct 2024 18:46:43 +0800
Zhihao Cheng <chengzhihao1@huawei.com> wrote:

> =E5=9C=A8 2024/10/9 14:03, Richard Weinberger =E5=86=99=E9=81=93:
> > ----- Urspr=C3=BCngliche Mail -----
> >> Von: "chengzhihao1" <chengzhihao1@huawei.com>
> >> An: "Benedikt Spranger" <b.spranger@linutronix.de>, "linux-kernel"
> >> <linux-kernel@vger.kernel.org> CC: "linux-mtd"
> >> <linux-mtd@lists.infradead.org>, "richard" <richard@nod.at>
> >> Gesendet: Mittwoch, 9. Oktober 2024 04:23:02 Betreff: Re: [PATCH
> >> 1/1] ubifs: Try to recover from missing znode
> >=20
> >> =E5=9C=A8 2024/10/8 21:33, Benedikt Spranger =E5=86=99=E9=81=93:
> >>> After powercut on a system using ubifs mounting failed:
> >>>
> >>> 2024-09-30T12:38:26.880487+02:00 sonja kernel: UBIFS error
> >>> (ubi0:0 pid 2178): ubifs_read_node [ubifs]: bad node type (255
> >>> but expected 9) 2024-09-30T12:38:26.880506+02:00 sonja kernel:
> >>> UBIFS error (ubi0:0 pid 2178): ubifs_read_node [ubifs]: bad node
> >>> at LEB 103:46920, LEB mapping status 0
> >>> 2024-09-30T12:38:26.880509+02:00 sonja kernel: Not a node, first
> >>> 24 bytes: 2024-09-30T12:38:26.880510+02:00 sonja kernel:
> >>> 00000000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >>> ff ff ff ff ff ff ........................
> >>>
> >>> While traversing over zbranches during the journal replay one
> >>> zbranch points to a znode, which was not written to the flash and
> >>> therefore the flash is empty.
> >>
> >> UBIFS guarantees two things for znodes:
> >> 1) all index nodes(in commit seq N) are written on flash before
> >> master nodes(for commit seq N) are written.
> >> 2) all index nodes(in commit seq N) won't be erased from flash
> >> before master nodes(for commit seq N+1) are written.
> >> So, I don't understand that why znodes not exist during journal
> >> replaying?
> >=20
> > In addition to that, is just one znode missing or are larger parts
> > of the flash empty?

Some background:
The system producing the broken image runs on an older kernel version
(4.9.286-rt189). Attaching UBI performs without any error. It seems,
that there is only one znode missing. There are empty parts on the
flash, but as far as I can see all PEBs have UBI header Information.
The missing znode is somewhere in th middle of an PEB and other znodes
are in that PEB.

> After reviewing the TNC related code, I cannot find out any illegal=20
> behaviors to make znode lost or valid index LEB erased.
OK. Is it possible, that this behaviour is caused by a already fixed
bug? This happend on a system running 4.9.286-rt189.

> Hi Benedikt, could you provide a corrupted UBIFS image? Let me try=20
> getting more information.
I need to clarify this.

Regards
    Benedikt Spranger

