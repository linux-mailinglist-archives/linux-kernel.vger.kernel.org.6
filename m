Return-Path: <linux-kernel+bounces-172237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD1B8BEF4A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 23:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1CBBB21123
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 21:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A6114D2A5;
	Tue,  7 May 2024 21:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="usY0vJvA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195757640E;
	Tue,  7 May 2024 21:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715119166; cv=none; b=J47qmpNVk8qF7YTkt0SAFgpvgojc10n26EutiqfdrZ3UZlsSubBAf3eFkor0mSlUX0bLldv2bUCe9v0ggXgtLcicQaaO3sLRBM0rO3wLrBf6fsmlZsL+cFwc/Vt4YLAD2ueFz6uyDHUbtAriIAhLGFd1u4nMKtkBJp4Harh/I+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715119166; c=relaxed/simple;
	bh=6Tx8Ao+c88e5pawNIUE7BBmPVhW/I8eksE19lk+ATSQ=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=TpFJrZBbLSXGbXVtbq6N0bgRY5bx3vzxK+1KbW1L1DzvS5ALVGUmYhF5/ch3yeUpXNkQZRqD8dCLVDqmsi3dnQQlyuhrWtFU7AIOdf0JzHAFilF2N5cLj/wxgxH6UrAb+9t7+V9Ngv6l2MtY+UWFkObY2ClloYQbCEJRYzaqp2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=usY0vJvA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844D2C2BBFC;
	Tue,  7 May 2024 21:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715119165;
	bh=6Tx8Ao+c88e5pawNIUE7BBmPVhW/I8eksE19lk+ATSQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=usY0vJvABlPssee3xoVzWRzL6N2TqDEtGQsy8HjAY0JGe4v6mn1Mr7Zy7wDjz4BWR
	 4bGxp/3AnOzYCx8pS2mr85FtqgcegYk/OYxDVuDBCb/RCE24Eej521k6TPkZeAVsxM
	 UDTYyrZlouGxS4FRW3fgeVbA6Hjv6dej6GIGk4BfzVovH+516EsTx4n2G1csJcfd35
	 af9h43MHsYPD2XZyE44vx/9Z2yqB3gga5xjDnShwlh2imoM7KiQjCHA0Wu7fY1dwPc
	 hMR9zj2aj83eVQy4TjXLIFRV8I/7T70nWgS6uvyMWy2l6FGYZRSYNkV49pyjQDqnQv
	 EK807WczBp45g==
Message-ID: <dab1901cc1de2688977340734c252e98.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240419152723.570159-2-gabriel.fernandez@foss.st.com>
References: <20240419152723.570159-1-gabriel.fernandez@foss.st.com> <20240419152723.570159-2-gabriel.fernandez@foss.st.com>
Subject: Re: [PATCH 1/4] dt-bindings: clocks: stm32mp25: add access-controllers description
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, Conor Dooley <conor+dt@kernel.org>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>
Date: Tue, 07 May 2024 14:59:23 -0700
User-Agent: alot/0.10

Quoting gabriel.fernandez@foss.st.com (2024-04-19 08:27:20)
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>=20
> access-controllers is an optional property that allows to refer to
> domain access controller.
> The RCC driver will be able to check if we are allowed to register
> clocks for a peripheral.
>=20
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> ---

Applied to clk-next

