Return-Path: <linux-kernel+bounces-342972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAB1989552
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 14:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507E81C216D6
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 12:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3A31779B1;
	Sun, 29 Sep 2024 12:26:14 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6C918E29;
	Sun, 29 Sep 2024 12:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727612774; cv=none; b=QdtP83+3E1lZZR06g788hF6PFOquuSWnpd5bFRFUmQBVSA5QNnfkbuqKhvxi3hYBdqhOjtt/SfHKZwCG0tlywj6k9FoY+PsjS+MwA9bF1gpr1OepJxJdQCwHE3mU1ThZVsZijGUFIK2VDtNKm+qcxTWJZELIosUn76oim8BSEds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727612774; c=relaxed/simple;
	bh=o+0v079A0kOT3XC+fSfIhiK9XQF0YP3wrF9y6rIeX50=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=V1tpFdvETRXZYJUlXIHJlCImIPv4WUdHeYU6pD/hfvjfSGwmWo4tEOlKYCn4MBa4S9QBT+FuYVlvW2gW2p+sdl3zOrYJv2bqwuIMOxi1bHj5eH9Ddxm40I0zV17l/PGM92pddCCl3PMp0N6NBZyifl1Pw4qHoxtx+kmf+7szK4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 5B7C064CD878;
	Sun, 29 Sep 2024 14:26:03 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id AVCXFA8yoKkP; Sun, 29 Sep 2024 14:26:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id C8C2464CD88C;
	Sun, 29 Sep 2024 14:26:02 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 594Xe0yKtZV8; Sun, 29 Sep 2024 14:26:02 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 96B2164CD878;
	Sun, 29 Sep 2024 14:26:02 +0200 (CEST)
Date: Sun, 29 Sep 2024 14:26:02 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, robh <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	chengzhihao1 <chengzhihao1@huawei.com>, 
	John Crispin <john@phrozen.org>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <251386789.117942.1727612762462.JavaMail.zimbra@nod.at>
In-Reply-To: <b43a7155f80995c3986893951c092291caf3a5f4.1727527457.git.daniel@makrotopia.org>
References: <e0936674dd1d6c98322e35831b8f0538a5cfa7a3.1727527457.git.daniel@makrotopia.org> <b43a7155f80995c3986893951c092291caf3a5f4.1727527457.git.daniel@makrotopia.org>
Subject: Re: [PATCH RFC 2/2] mtd: ubi: add support for protecting critical
 volumes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF130 (Linux)/8.8.12_GA_3809)
Thread-Topic: add support for protecting critical volumes
Thread-Index: FCmHecnztBfMlrKyZF8gLM/3GCQN9w==

----- Urspr=C3=BCngliche Mail -----
> Von: "Daniel Golle" <daniel@makrotopia.org>
> Allow the boot firmware to define volumes which are critical for the
> system to boot, such as the bootloader itself if stored inside a UBI
> volume. Protect critical volumes by preventing the user from removing,
> resizing or writing to them, and also prevent the UBI device from
> being detached if a critical volume is present.

I agree with the doubts raised in patch 1/2, if userspace is so hostile
to delete system partitions, there is little hope.
But I'm still open for discussion.

What I veto is preventing detach.
This makes a clean tear down of the system impossible.
It becomes more and more common that advanced userspace shuts down
everything it setup during boot. e.g. while reboot switching back
to an initramfs, umounting root, shutting down all storage, etc...

Thanks,
//richard

