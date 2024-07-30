Return-Path: <linux-kernel+bounces-267850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DE3941750
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D72481C2342D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58562189517;
	Tue, 30 Jul 2024 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hgzOEf/O"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA50818800D;
	Tue, 30 Jul 2024 16:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355681; cv=none; b=gLLxm+jO09AYnfXAcXMY7XQGyRtt4obdY5xASoCk0EjmvG2tGakBEDpvBGBhJ9gSIFvRElSPO7QbTZiMCqIy6API1lqCqffKAfb/Rv0dSPIXKwdmey7ti1MGDVYi5iKPEalASC/tnhSxU+UHsvdElq4R24TzH/pJnBXpqyiGQvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355681; c=relaxed/simple;
	bh=2VoCCEGCWH1okrC4/aYJVH1VOXJFu16fNG1bvUcPhDU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=ZG6xwnIaXNtIbLKjWAzFep8uAQi4HWnwRqWPUM6LMav0n61boux6c7w/bUiZY1BKcMXza+XTm6pyhpo96hk80ZfeWy8H48DvYvBRe5y6BKznIXWirrK7uRkZi8J1VYUerMoEkfLwo6AMXBnXX5cL0q1y45hwCQ/uFqxR+o9dvKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hgzOEf/O; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9D4682000B;
	Tue, 30 Jul 2024 16:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722355678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2VoCCEGCWH1okrC4/aYJVH1VOXJFu16fNG1bvUcPhDU=;
	b=hgzOEf/OuSaHGErpC2JGzfT2mOp0qWfS/+MIzexGit9bXgf2ramVkGwo4fQj+/B/CjFefE
	0NWrfFAcCV+kJgH+e0ePtsFwpsQDFP8VZ9EHfgKYprSS/dv7rfahxyXlSaKOZVXzWAA/js
	/GZ+8AITkIbtB3FRxEEhOhKQ3DxvXGwh10eEyxmhe1Pobp+Pz6BpVrgLxEdlRhjIcwkWxS
	ugHNboEIn1lsmkc8ETYHj5Sp1Hmj4Uv7bzrU5sR7A89H+tlF5ZxYE+X1SRhY241b3Ob/7W
	ZYPV/DgEkaukVpdnoAuTAAvW0EBI44FDm4cPyU4GQoGS1RB4whrGv7gL+kAcGQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jul 2024 18:07:57 +0200
Message-Id: <D3304R02WPLT.VCW0EQMVM52N@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH RESEND v2 0/2] Add Mobileye EyeQ reset support
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vladimir
 Kondratiev" <vladimir.kondratiev@mobileye.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, "Philipp Zabel"
 <p.zabel@pengutronix.de>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
X-Mailer: aerc 0.18.1-0-gaa8319bc591f
References: <20240730-mbly-reset-v2-0-00b870a6a2ff@bootlin.com>
In-Reply-To: <20240730-mbly-reset-v2-0-00b870a6a2ff@bootlin.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello all,

On Tue Jul 30, 2024 at 6:06 PM CEST, Th=C3=A9o Lebrun wrote:
> This is a new iteration on the Mobileye system-controller series. It
> used to be sent as a single series [0], but has been split in the
> previous revision (see [1], [2], [3], [4]) to faciliate merging.

This is a friendly RESEND of the Mobileye system-controller reset
series. It rebases with no issue on v6.11-rc1, and works as expected on
real hardware.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


