Return-Path: <linux-kernel+bounces-208307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C74902356
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DAD7B21E97
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB8112FF63;
	Mon, 10 Jun 2024 13:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="nqqkPOba"
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E0A78B4C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718027907; cv=none; b=ZGKNBWVo8lDUPs2hN9eQRIE0qlEJ1C8YmVEsRNPmoG4YDMNDdmT0V/PYa1gpU2Ik5BQy1HxEE4XiiHJwnGgewwvTjwmpG/Lrk/e5wxK0Vu0IyhMhSJLo+yKWtfrL1475bFFwYmUAQoLlhS7TDP7HQNaQrX5dMHU5zHOHnxlcl1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718027907; c=relaxed/simple;
	bh=IlEiVQcDobXYBXuQyHQKvoTdmOjV+daXxE4s+ZP8G9U=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Ixd6N3O/im0hDe7/E7DMAJjtnz7xYy1XYiFBc/2Ad4VYv6xwL4mlVc360PrdSKFLEEyAE+ADrP08dDpxBZjX1io7kJG8phfp+4ToskXfMc9SsSB5cN/3vDu3BM/0B+hN+it+iGMGlHWRygbLZoC8nUbO3vfTckO//rMlawdW27U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=nqqkPOba; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1718027898; x=1718287098;
	bh=IlEiVQcDobXYBXuQyHQKvoTdmOjV+daXxE4s+ZP8G9U=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=nqqkPObaHIoyvEo0mC7aUtRK71rYLa9g7fJ7+6V5c3asK4U1AkbsYseVDUQIm2ihi
	 DZxDhv8FAdibziHYfz7pKzmtWDIVOXuBHFUBJ6yOVEKbaXFTvIEdBNOG8odau7oH67
	 t1I52H+ajezuWEzm3zYF7gSzAW/zmx86Ew3adEroU42L+2J6fhhC6wjrOAP2iiMEiP
	 697IoP7vHkGnW5oWPmaQWGOIltQnfeuEr5cABsusy6+v203fyAnghasvc3/Sa5Z4bf
	 USRlOq9Fbmfx7/EuL9p7LcvTfOFlcuNz4QvsA/1plyURirlpVJK0gE9d9yuvmCV4K5
	 csz2IWYgDHGjg==
Date: Mon, 10 Jun 2024 13:58:15 +0000
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: Will I encounter boot failure after upgrading the Arch Linux on my Aftershock gaming laptop to Linux Kernel 6.9.3?
Message-ID: <gcm7F5ILYLVuUJpYpWWT0lEKZbJ_mdWmHd53FOqjtYMi9YduWVYha9ra6SsqBN0XJ7L544kHYisEd2pIwfODtpv0iiBrTb8HEA2ldd4IqYY=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: c34a5a2f60a14c2540c7e96fc3df47e52858b5ae
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: Will I encounter boot failure after upgrading the Arch Linux on my=
 Aftershock gaming laptop to Linux Kernel 6.9.3?

Good day from Singapore,

Please refer to the following forum topic.

Topic: Boot failure after upgrade to kernel 6.9
Link: https://bbs.archlinux.org/viewtopic.php?id=3D295923

It seems or appears that many people are encountering the same issue.

Are there bugs in the Linux Kernel 6.9.x series??

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Targeted Individual in Singapore
Blogs:
https://tdtemcerts.blogspot.com
https://tdtemcerts.wordpress.com
GIMP also stands for Government-Induced Medical Problems
10 June 2024 Monday 9.57 PM







