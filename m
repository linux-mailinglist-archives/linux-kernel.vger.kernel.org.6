Return-Path: <linux-kernel+bounces-538809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB4FA49D47
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BB463B7AA5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB03272934;
	Fri, 28 Feb 2025 15:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="YED3jtW2"
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86CA271295
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756128; cv=none; b=Sedlv4ey7sHAGRQSI4vvnvAHo5CagEda3i+WMLOqkm417kXroTOIPv06cyM8px6h4hOgu7EAX8MMu5cbN4MDY8Hj2aNR9bxOjlqSPz4qsWUirZaUaRiC5pAqkxoyXmMG4m+xs1UJ7tPXUDZgOpcqI306JVIJhmRbwDagfqEzMQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756128; c=relaxed/simple;
	bh=eqs/Lnpa4HkOnUBSn2LQUsgIYfqi/oQAXcXZ9B7TE84=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=i1jgLCRcFrz+CnvLaiSBzIdfv4ag8yf+MVuQHBXRWAL9CG9Dgj5bmmp5PLG/JAOrB7yxgypHDw6HhosxN3oJkqC63cHCSlB1647JI9uGYDS9xo3wAYKCb8wA/S9axPxInRX8FLeOs9w1UuJ6/nq286H/GgC5klXXUfu0T2Zg77I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=YED3jtW2; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1740756110; x=1741015310;
	bh=JWWk337awRNTupWNOkbpgoyh1dVUMVeu3JpqFA6eCLQ=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=YED3jtW2WBDO9Tf5yZRBkKifcuXZecItwvMFYABgoNQa3Gs2MJ7tLGjpaTJCGkM+E
	 Hg0Of41clfCuon7AfIJUUgV6vNzlbEhRFEoYIkGS81ttOfNVe6OS8MPNrwnRQo9mJ5
	 Bc4MSzkUKHp4xK3Dz/XIXFCzSzC25c4Zomomo3kE5wFehDKCwtocNXUI53QbKLvTne
	 QyoQEfQH1FIRCRDXkgm/GPFiHl7CPCpDI02KopAEuFxbvpY4osmXmgIb98bjN0sC4h
	 4hx/ccHIUjA2y8V5kOyRLlAskDhxon37Fq3cpl0+IghkzHEC4G3Mi227bJ/mN6JWrq
	 gY9IEAWb+dXrw==
Date: Fri, 28 Feb 2025 15:21:43 +0000
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: Where can I download Cisco IOS-XE software, since it is based on Linux?
Message-ID: <bBGfznJBYFxQuIVC8ITSnt1ylbdJXuqWXRGlZKrfzixBuQfx9tKWHxtxyYlGfUI6NI3nPhKz9GuAO9OJMNJ-NMXnr9yjgEvpq78RKBPUXmQ=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: 7777c6bb0901ff579520a48615e34f8e9acb21ed
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: Where can I download Cisco IOS-XE software, since it is based on L=
inux?

Good day from Singapore,

Where can I download the source code for Cisco IOS-XE software, since it is=
 based on Linux?

Please refer to the output of the "show version" CLI command below.

[CODE]

Cisco IOS XE Software, Version 03.16.10.S - Extended Support Release
Cisco IOS Software, ISR Software (X86_64_LINUX_IOSD-UNIVERSALK9-M), Version=
 15.5(3)S10, RELEASE SOFTWARE (fc4)
Technical Support: http://www.cisco.com/techsupport
Copyright (c) 1986-2019 by Cisco Systems, Inc.
Compiled Fri 04-Oct-19 06:36 by mcpre


Cisco IOS-XE software, Copyright (c) 2005-2019 by cisco Systems, Inc.
All rights reserved.  Certain components of Cisco IOS-XE software are
licensed under the GNU General Public License ("GPL") Version 2.0.  The
software code licensed under GPL Version 2.0 is free software that comes
with ABSOLUTELY NO WARRANTY.  You can redistribute and/or modify such
GPL code under the terms of GPL Version 2.0.  For more details, see the
documentation or "License Notice" file accompanying the IOS-XE software,
or the applicable URL provided on the flyer accompanying the IOS-XE
software.

[/CODE]

Since the Cisco IOS-XE software is licensed under GNU General Public Licens=
e Version 2.0 and is free software, I should be able to download the source=
 code readily. But Cisco does not provide a download page for the source co=
de and requires us to purchase a service contract before we can download th=
e software.

Thank you.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Targeted Individuals in Singapore
GIMP =3D Government-Induced Medical Problems
28 Feb 2025 Friday







