Return-Path: <linux-kernel+bounces-267845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8299941728
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51CCE1F25445
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0F418991B;
	Tue, 30 Jul 2024 16:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gnaypIPH"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A6E18951A;
	Tue, 30 Jul 2024 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355580; cv=none; b=Wa9ABG/SzwmxH98npjRCjo7eOrQtPPXNna1S+YhaplYodVF7wepWw4dguXBW2ojQKqletsT4rwZTTh9Tneu2Lkw+IByy/cHuGrPacxsV+ptUTCKvzoTtMkm/B484YuuT0aeSeByCUGr+uIa6oF/kaC5TkeoRCuhfQf/0FeVuqnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355580; c=relaxed/simple;
	bh=Sbb0X0ZQ9wCjmWJvyc91Z9FyRyM6zMDTso6l6mTO/J4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=F34M0yOpjcdoF0vDxcuNJSPmFmu8TEcLcAoErIDGwOhI/PUbk65qCcYNiMf37h1QJz9dMiYlWXs6gK4UhN+DIDFTS2+/hLF0rW591eHDQXaN1dNn/LPJ3FN271gqiYgy5MUB/ycpa6LvCUIlTjgTEYZAit40472saU1A3XzfOGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gnaypIPH; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0CCD120005;
	Tue, 30 Jul 2024 16:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722355571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sbb0X0ZQ9wCjmWJvyc91Z9FyRyM6zMDTso6l6mTO/J4=;
	b=gnaypIPHeJXLbymRx/Bj8sCv3NWRW1DNo8rH13DfltCTwlbL4nIfp12QeF83lYd4zZB8b2
	AGY7epVGBdZ/ODAU1mU2gyEhk6IX34yC0VofhkfoxU2MPSf/kJG9cgTdINzeB/MUQXiUk7
	3E2ucbznKiKeGnX1gd07+PfsLXZy31Tu1jh03vCaIjzxxeU8tdg2wtrpD1lX6UKnhSd+Tj
	OUbx1m4YLiW/CwZn3PBIuB/AKEJGcCF+A5whXiBDVXgXSEOxxTxpor4stx0wC8x1dQJJ7Y
	YV/a9n2Q5mAzy+D2oP0g58RoOTVQs4Yid564I42VrAn8TY+WUhZ7TXUNYYfldA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jul 2024 18:06:10 +0200
Message-Id: <D3303E0OHP9L.2J35O9HU9HJ1J@bootlin.com>
Cc: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@linaro.org>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, "Michael
 Turquette" <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH RESEND v3 0/4] Add Mobileye EyeQ clock support
X-Mailer: aerc 0.18.1-0-gaa8319bc591f
References: <20240730-mbly-clk-v3-0-4f90fad2f203@bootlin.com>
In-Reply-To: <20240730-mbly-clk-v3-0-4f90fad2f203@bootlin.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello all,

On Tue Jul 30, 2024 at 6:04 PM CEST, Th=C3=A9o Lebrun wrote:
> This is a new iteration on the clock part of the Mobileye
> system-controller series. It used to be sent as a single series [0],
> but has been split in the previous revisions (see [1], [2], [3], [4])
> to faciliate merging.

This is a friendly RESEND of the Mobileye system-controller series, now
that v6.11-rc1 is out. It applies just fine, and has been tested on
real hardware.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


