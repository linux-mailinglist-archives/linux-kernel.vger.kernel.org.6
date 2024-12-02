Return-Path: <linux-kernel+bounces-427085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 125B39DFC3A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86312B2120B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC651F9F5F;
	Mon,  2 Dec 2024 08:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAhKsO1Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1067A2940F;
	Mon,  2 Dec 2024 08:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733129027; cv=none; b=ApNSk58U36HrwgKn6SR/YpabGrCWy9bdpM9rrPx4uaR0uWFPzSnGIL8Y6cajix1NMjz4HGcyuAGQSlVFr1VEUrNHBjVTOlmgwvbDfUf1IWCuVD5/yk2GEmdbNxXTtvhLxmjihT+T1fFsLMV+LgpN8MuDntvvqi5nA3nTzUwE1lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733129027; c=relaxed/simple;
	bh=1sVtE4uEehXRaXvN8ESWtlHpi3uBM+vuC6madLMzWMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+hWiwxRZ4Ny4gL8wfU6J/DpOOVSBEmTBecKkrlHcZu+/CtPfrQt2rCACa6YeSGUaqVobRiPNm7gZDsqAO1PSDoSr/FfuCI+dCl0dDLmMzkk0Ed21MIHfy+wAhFVXjwKJsh5OXJIv5x6vhjAkj7zFTzDAiBA0Y0vgayMq5ZO1aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAhKsO1Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C6DC4CED2;
	Mon,  2 Dec 2024 08:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733129026;
	bh=1sVtE4uEehXRaXvN8ESWtlHpi3uBM+vuC6madLMzWMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eAhKsO1ZCB6C8tH1oHhPNC6qUnt3JiCyhQkICTjOLNWZ2fX2yeCd/Ie8wnOFhaUsj
	 uMVNBDCIHwSTxVDFHoL2ZXn8jM/1PO/xGioAX8+qtl/Zl8UD6RpjgrL49jetT6ozmz
	 QIdQqEcGxygSYNARdko3t7GwJftZ1lbmdYLL6qKbEXggGZS48M5SgpwIXHB9RDoo/5
	 3b35nWnCl8SmxCwRViRo9AFuO37fUfWF/8D0UiRQyNJXIlRGVduwdhIkIZFPsfhbcI
	 3ru8r7O+5JD0seDtC9t1UrfMv8a3w6a9D6RqJqI4GG4aQi7T+iLMLyg0vfFTGJYFs8
	 K9cT8BpofYxvg==
Date: Mon, 2 Dec 2024 09:43:44 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Cody Eksal <masterr3c0rd@epochal.quest>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Parthiban Nallathambi <parthiban@linumiz.com>, Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH 1/2] dt-bindings: sram: sunxi-sram: Add A100 compatible
Message-ID: <xos2khgdmnt6iinglnuuat6ak7bxzrufw775stmoy72igul7b7@5oqu374t2764>
References: <20241202-a100-syscon-v1-0-86c6524f24d7@epochal.quest>
 <20241202-a100-syscon-v1-1-86c6524f24d7@epochal.quest>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241202-a100-syscon-v1-1-86c6524f24d7@epochal.quest>

On Mon, Dec 02, 2024 at 12:43:26AM -0400, Cody Eksal wrote:
> The Allwinner A100 has a system configuration block similar to that of
> the A64 and H6. Add a compatible for it.
> 
> Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


