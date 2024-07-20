Return-Path: <linux-kernel+bounces-257863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D965E937FE2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 10:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943D928175D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 08:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56D744377;
	Sat, 20 Jul 2024 08:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="NQ4Ebzg0"
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FEE43152
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 08:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721462459; cv=none; b=p7QIl9XzoqJ9k/jCpU11EF98IYm7RWT1wI3mJu2L2XKGkKoFp31dfh8OMKfIjilro9XFJuS4o3mrSKlGFerIRbEv5Du8XGiNc1hwKvbbplBXltpd3L1FsbCj83jErAJgo1zDkhhFvrzBqnneADjcPnKbjPYsD2W2LE6FaOQLokc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721462459; c=relaxed/simple;
	bh=DPHT+BfOa0vagYpe7nlw5q4gExak7dRfzS6eOSek5Us=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=NIqAI3HWwqhHLmegAPm9OkB3WVrHm4edcZBVBQ/MngP05ajq9kpMQktF773+VjqajaoD193/X9VcJSv8SLQNwrJWxOU6+1yptiXa8Qgqxcftu/YGiPu/AHVPJHO70AEWXkGFTA97ZjpWtmTUbUkhdHeU0QM0z37r0TarEioi/Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=NQ4Ebzg0; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1721462447; x=1721721647;
	bh=zAyD8N1jd8wn9zgkPHwTpcBdJue2QBdmN1NS7myffk0=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=NQ4Ebzg0R9kxkThvFmF8ezo+gubrz6NW+abasAj2v6ZOwaLu1tOeDTPN78aLE7gIx
	 81pymRfZfPTLaKdDggi5HnvjDrgGMFrUsyoBGsHhmvxv9FJU9g+okvkCEQltivjBy2
	 i9R1Vc04b+mhoBsGs7RrqMABABhHbctRObc8vigRCAUnXeZXlPeqUmCsBU3V+8T85o
	 zNmztIjRhs5BTgVFW+viG/5nDdgpn+dPFjz6eWt86zekdz/CRekKDIaS/rgONgt4DP
	 fXKREGipglBJVrLX1+hVhCjIPDc6vI1/23v7s+KX/DgPlt7BlZCCYvP+9tyj5XsR6k
	 Ww8ziE1O0xNqw==
Date: Sat, 20 Jul 2024 08:00:43 +0000
To: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
From: Jari Ruusu <jariruusu@protonmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Announce loop-AES-v3.8d file/swap crypto package
Message-ID: <zIEccC4mfA_ETwu4qTNHosdNy5ng6aeo8PmR_29jPqGEg18eo55fkS9OodYvXyY9sY5wgF991xwnGSHSpi_YE4e6g888l6mpV-Pb91KXUoA=@protonmail.com>
Feedback-ID: 22639318:user:proton
X-Pm-Message-ID: 972074221727eb9ced1fa452b6135c841dcf9287
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

loop-AES changes since previous release:
- Worked around kernel interface changes on 6.10 kernels.

bzip2 compressed tarball is here:

    https://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.8d.tar.bz2
    md5sum 47ec963e18ed1ac8e8b471d3c15e3b7a

    https://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.8d.tar.bz2.sign

--
Jari Ruusu=C2=A0 4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD=C2=A0 ACDF F073 3C=
80 8132 F189


