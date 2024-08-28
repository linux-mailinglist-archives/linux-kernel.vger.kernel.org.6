Return-Path: <linux-kernel+bounces-305258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D12F962BFE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 604F71C23DBA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F1D1A3BDE;
	Wed, 28 Aug 2024 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ig5SOHDF"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7367313C9A6;
	Wed, 28 Aug 2024 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858267; cv=none; b=SQM9sSVnB7NrZ4QNUnU3zkRin9iQpdltDW+IoNDsISW43AQ2L1ISFNe6nqrUWAnEj6kVxuWnut3gHGU1IEmPqBC45BT0ZHu/7cxJfqZbl+uUiB1M8BDRSrCrVHdEu51WZtXX8/Jc8b3I0oMUR3tpnLxq4Q6EkKp0MlOVbExYOvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858267; c=relaxed/simple;
	bh=UELXDUdCnw74Fw72abGUB0LgJw1wixSsTaQ9/pgsrL8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=oPGkS53XyoNOkQoXKG1cVZI2xAw9Y/kQulUAO/a6nOadLIoFCyrhoL5Sd+Lj7y0Ynyr6h9jTCjDML61lLasgKk1oJwmK/slZnjl7ZtoR9QdiFlET7H7cOXSgQ2lN5RWmMnscuIdojJnkKXgqlVJPqJEyGMDeh2xT6endN+cVMqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ig5SOHDF; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2C527E0004;
	Wed, 28 Aug 2024 15:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724858258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UELXDUdCnw74Fw72abGUB0LgJw1wixSsTaQ9/pgsrL8=;
	b=ig5SOHDFEFR+AhMVx9l15rlyQj8SUKJ9kOp25ddMKD07s4nqJw6AYUdAL1lKrsh0CbrqfR
	zr8AxwtzGj2eVe4ijZznrJ7mnbrEjW3WqkTyB4T9UA19OXT+NVdMLly0eyXD3Oj3RiQfd4
	PTMSIfp4UV3L7MooU2gQxYV6NhXyVTrIbPkEtQRI0XJLU5RjwM0SUaV63zzcWuczeEQTpb
	0Bnhs/LJ72SePTGmej1cQgHGKctbv3En1mv469wcv/haGuiOiajIjtVrMqBg7Lzwm9GKe+
	BQHiVLGpmRnpGlAJPK0YnFHwFQhssdj4mIwdI779Utg3XSpcrMK5tHPilQ4b1Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Aug 2024 17:17:37 +0200
Message-Id: <D3RN80M69GO1.3S9Z3AER1QJ9X@bootlin.com>
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vladimir
 Kondratiev" <vladimir.kondratiev@mobileye.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, "Philipp Zabel"
 <p.zabel@pengutronix.de>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH RESEND v2 0/2] Add Mobileye EyeQ reset support
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20240730-mbly-reset-v2-0-00b870a6a2ff@bootlin.com>
In-Reply-To: <20240730-mbly-reset-v2-0-00b870a6a2ff@bootlin.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello Philipp,

On Tue Jul 30, 2024 at 6:06 PM CEST, Th=C3=A9o Lebrun wrote:
> This is a new iteration on the Mobileye system-controller series. It
> used to be sent as a single series [0], but has been split in the
> previous revision (see [1], [2], [3], [4]) to faciliate merging.
>
> This series adds a platform driver handling SoC controllers resets. It
> is an auxiliary driver being instantiated by the platform clk driver.

What's your state of mind on this series? I am happy at how it turned
out and believe the whole system-controller for the platform is modeled
properly now. It works as expected on real hardware. Pinctrl got in.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


