Return-Path: <linux-kernel+bounces-432934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94039E520B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F534167889
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726281D61A4;
	Thu,  5 Dec 2024 10:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="m5Q0Boa0"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783161D461B;
	Thu,  5 Dec 2024 10:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733394139; cv=none; b=ClU+aqzWe9EF51VAOksEd3wMBf9Zu7ConMLml1Sq5v+LoU+TuseOB1q734aViqjUzdKE3D9MyHTDU5/ZY/1FuhPbfkHxJS1Kfz4e+vVki5PnY1wPzSOg5p+3DKh0AR7pwnzqDxwEBRF9XT1v3UngtV5ing9MY5bymucv+wXm2RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733394139; c=relaxed/simple;
	bh=uWVQ/v+7+PpcMMQalZl/ZZIHqM8C8QG5E8x7U8XrtwM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c4o188COiabE/iN51WFVH/JkmY9rlyxz/WYI1SG2Vbb0qmjZ04+G4cCnDkj+XJTUmQWwWeifNBn5WCy3kOuFlYV9g0xfmxKWtliLCbj8GuYshzYyNODm2R4WxFUp9b0EtGezSkj/Ggv1TG8LXi6QIOb8DlUQzTiRc4wXD9GX09c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=m5Q0Boa0; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9E7822000E;
	Thu,  5 Dec 2024 10:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733394130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uWVQ/v+7+PpcMMQalZl/ZZIHqM8C8QG5E8x7U8XrtwM=;
	b=m5Q0Boa0AKcnlqjAkyujMXhcHPjQZKn54uFHD8d/bVh58AuEwXuESPejvIb1oNmgDd/1/p
	zBUPiTuVSuEEpI/U1XNNv4z98cLHEgkVwzWLoEnZC+UtqRvQ+j8NWBJKf2oATFxQQ5Vq5k
	UM+SFu6lfWrl3sWBjr8lPiJoR94q1VsCNzNx7hYVEj3Zt+FRBE+ywZFXakZu+UHmk6+lon
	6JKmqAUmWLcGGTDecZngNEyCb6Nwa2NcYtyvFjaRX0n2pWChAC9wDVNW1BMZjrzy7ITV2N
	bAsowrMktSem93DIVIUWK5YFGku6gWun7gsGxtu1DwaE+hm59kzblfHjcUjkRg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: niravkumar.l.rabara@intel.com
Cc: devicetree@vger.kernel.org,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: mtd: cadence: convert
 cadence-nand-controller.txt to yaml
In-Reply-To: <20241205053350.434370-1-niravkumar.l.rabara@intel.com>
	(niravkumar l. rabara's message of "Thu, 5 Dec 2024 13:33:50 +0800")
References: <20241205053350.434370-1-niravkumar.l.rabara@intel.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 05 Dec 2024 11:22:09 +0100
Message-ID: <87mshawhta.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

On 05/12/2024 at 13:33:50 +08, niravkumar.l.rabara@intel.com wrote:

> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
>
> Convert cadence-nand-controller.txt to yaml format.
> Update cadence-nand-controller.txt to cdns,hp-nfc.yaml in MAINTAINER file.
>
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Looks good to me, but I'll wait for binding maintainers ack ofc.

Thanks,
Miqu=C3=A8l

