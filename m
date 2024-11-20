Return-Path: <linux-kernel+bounces-415416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA129D35C5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B28592836AB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53C818453F;
	Wed, 20 Nov 2024 08:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENQOLDc9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2547E15B0EE;
	Wed, 20 Nov 2024 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732092339; cv=none; b=evAUTE/YQlNbo94pZzGal0/eIGzmfLqE8my9vt7yKIEWIiP1YmdPVS6iyV+MS6ue8xiUuI8TZpu+jt+blBGJsy0DBTZpIhYB1gHZtYcPvWcG4qeroGwD0iM0CWo4CW6K3S4zCG7Wb0todYrgL1Frhc8KnMOe9aozOy35coRBv3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732092339; c=relaxed/simple;
	bh=o708dW0zpekdr4qHK55sfqdl8wG5Nu/+g3DIktqbevs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSxjybGMj0FcMWCc3b88x57cl/ISDUwldXstcZ5T8+ijjZKQTtrnhptB4pF6A3AIryeyDq1opMj0RrgfNER37IEK/Pla3itniYM8A/eJLyqWKQw/SNBiOqPRq7H1tSwOpq+RBgfcVCH8bNWEBPBDUwuOJ1AQYGltPUIiKUK1SoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENQOLDc9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B2CC4CECD;
	Wed, 20 Nov 2024 08:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732092338;
	bh=o708dW0zpekdr4qHK55sfqdl8wG5Nu/+g3DIktqbevs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ENQOLDc9QlSnqdhpi5D3zXCMMfPjp+W242ba0E8V20RP4FD0uAEbL1XjgeTcXw5rR
	 ZMp+mkKdTDwaJb+uuhLbkI46ajEPAR0PxWOa1Y9DBLiZwYLDxmgm3aVHjRuUJgJ6cZ
	 HH0Y146jPZ/3JXkBZq00o7riCQaKfAlKMv/kealJDq7YwCkng/jvMRZwe00H5ALxcy
	 q4XVXfT7XYRXqF7hWjeRbsKFRWXxNAxv1eQduNpqx7Qv2G0DjLSEMSEDUoXKvGrKNo
	 ob7Yi6O+uC6vp4o+QggxaLzv+gAUjuy8A39xd2Ji1AdUisDBgDv/9cnXcugH6FL4bH
	 bw3j4mq4W04WA==
Date: Wed, 20 Nov 2024 09:45:35 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	kernel@pengutronix.de, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Leonard =?utf-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>
Subject: Re: [PATCH 4/6] dt-bindings: arm: stm32: add compatible strings for
 Linux Automation LXA TAC gen 3
Message-ID: <4t2tmuntv24lffk3ikgbsz7tbvkqosmd2xwurnzvk346daah22@wegcc3wreqpr>
References: <20241119-lxa-tac-gen3-v1-0-e0ab0a369372@pengutronix.de>
 <20241119-lxa-tac-gen3-v1-4-e0ab0a369372@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241119-lxa-tac-gen3-v1-4-e0ab0a369372@pengutronix.de>

On Tue, Nov 19, 2024 at 12:35:01PM +0100, Marc Kleine-Budde wrote:
> From: Leonard G=C3=B6hrs <l.goehrs@pengutronix.de>
>=20
> The Linux Automation LXA TAC generation 3 is built around an
> OSD32MP153x SiP with CPU, RAM, PMIC, Oscillator and EEPROM.
>=20
> LXA TACs are a development tool for embedded devices with a focus on
> embedded Linux devices.
>=20
> Add compatible for the generation 3 based on the STM32MP153c.
>=20
> Signed-off-by: Leonard G=C3=B6hrs <l.goehrs@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


