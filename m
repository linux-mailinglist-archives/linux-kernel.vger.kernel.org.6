Return-Path: <linux-kernel+bounces-432911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6369E51BB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948511673B7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2EB207662;
	Thu,  5 Dec 2024 09:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LWjBbzcM"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD196207654;
	Thu,  5 Dec 2024 09:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733392663; cv=none; b=mYia5YpNtIzNExWsZyX/SQZWF5zFWfVTaadQSls/4mwyoScUKJ1exPM+2TFStGtkTMjPefDMHp3wYHhx+1EdMBFICnmlU0rREBvdnZpWbgIdg/DxwN2mGSkXzVmPLJyLhUNm1X/gFShmais0SVsT1MbCpuv0i4xPIGwp94XPKek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733392663; c=relaxed/simple;
	bh=RpXPliZH6Zc0IudwYS7O149suTDWID3jOfvKZRoZxqU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e6b1HG3Q9b9+NlhJ/Hg/1isbwx32+QLT6RyjFH0tUlXi1fq04HRPIueZ+eU8wbLv+bKZMg0QXX4GM0ws5+30x8ZZ1jG+6JilTlJhtNQs7BztR+UJtQWe4mZrx5K0KFJ2njexvMJS3eWch/lq6ZjN0XqgSEm65w+boObcB9sCBWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LWjBbzcM; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 62FF860008;
	Thu,  5 Dec 2024 09:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733392658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=asMdUS02UFeTgHBuIcDcycZwkfGKntAm0QKtWLar3FI=;
	b=LWjBbzcMhQhmq1NPUtjqkyNNAxfS+5mnQI1aPD2Ok0Sn7+yN/1HDrurQ7zstLHrZtLGwYA
	Lao3U+F8f4gIyLW57e4gMTsg2ts5TX2VVGLUtB8JrYyCYd14OQdBuBVD5d9yPoseEQTyru
	hDtXdQfMFqhK70YB3xQZsp1aCqthpW46Hp/g/i31GS3hH/dAv41r9/vK/HujVoYjZHWjis
	BUCTKHQIYHtkGq49BjtxIUtM7Qw618ZHLZGA5yd3VxT2UvCe9pBu0m7Vvj6VUVFBrfHbDR
	wdOnPfvbYmT72VjaKEM59y+amCcljHzbSp+/8CA0IuBwsCu+qD43YXVOyaubqQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
  devicetree@vger.kernel.org,
  linux-mtd@lists.infradead.org,  Richard Weinberger <richard@nod.at>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,  linux-kernel@vger.kernel.org,
  Vignesh Raghavendra <vigneshr@ti.com>,  Conor Dooley
 <conor+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: mtd: fixed-partitions: Fix "compression" typo
In-Reply-To: <173324605959.1986625.7343237766910696825.robh@kernel.org> (Rob
	Herring's message of "Tue, 3 Dec 2024 11:14:21 -0600")
References: <20241113225632.1783241-1-robh@kernel.org>
	<173324605959.1986625.7343237766910696825.robh@kernel.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 05 Dec 2024 10:57:37 +0100
Message-ID: <87y10uwiy6.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Rob,

On 03/12/2024 at 11:14:21 -06, "Rob Herring (Arm)" <robh@kernel.org> wrote:

> On Wed, 13 Nov 2024 16:56:31 -0600, Rob Herring (Arm) wrote:
>> The example erroneously has "compress" property rather than the
>> documented "compression" property.
>>=20
>> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
>> ---
>>  .../devicetree/bindings/mtd/partitions/fixed-partitions.yaml    | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>
> Applied, thanks!

No problem, I always have a bit of delay but this was in my "to apply"
list ;)

Cheers,
Miqu=C3=A8l

