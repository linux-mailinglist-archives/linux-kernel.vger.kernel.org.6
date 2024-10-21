Return-Path: <linux-kernel+bounces-373834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123F69A5D75
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C3E51C21D9F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC0D1E0DFC;
	Mon, 21 Oct 2024 07:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ud0yjX4F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4485D1D0967;
	Mon, 21 Oct 2024 07:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729496845; cv=none; b=Vx3Ki3JsI6BK1TwVAa7pZaFUe02ClgvY4g+/1SMPWOU4NRlmqHixP2DGz5ILSepWmz4L+LOfXz+HWWaQ4/fbmYc3ymETdv9aieWpUFhCDficEUsCwTd763WFPJlu4r0zt819b4NkF+h72IuAnDS9Pnc263vidm/77+5XLFcyC7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729496845; c=relaxed/simple;
	bh=QYPuRLdd/F4IvwRue6/tiHruJ1+0xH7i5ZM5AuYnrow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUzgTIwCFtobYNoIbWs274NRN1HbmXuuzxSf3Rw3RaRrLB9ZpcVG2xdVgdOZG+q8OEYTEdoH/L7dXAci/4ks/MXj//jbmy+IlF1kTklNdPCk5giLtbrh3JU/x6M/3R8j8vTR1mPD4UC0YvVIaNKu1EFAxMtoLCK/1RMdKSXhgs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ud0yjX4F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C9AC4CEC3;
	Mon, 21 Oct 2024 07:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729496845;
	bh=QYPuRLdd/F4IvwRue6/tiHruJ1+0xH7i5ZM5AuYnrow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ud0yjX4FFpziqB/SCc3RjPsiCY9Xw4j+9rSOrgLiJzC2zmy4UaX96c69yStTl2/mN
	 5Rd5mkdPQTn7HDjAkvXUMBDXAq0Fl0EAw19dDAMegX4J4YX0gyEmoWeq72f0AQ5aiv
	 7TrfruBmdq1E04XKBgcxYiGgtyn1jYWV9r7SRZJuMFeFynmmv4gdPNQdsw9WGBK5z5
	 aE6xNRdOZ5FHQWV0PCoChDlp9Pgj0K98bbU43xqNaf6AIAgnZ28W8D76/Qml0FSwZY
	 qaY30sXLZGxV3h6hJkfTSkq2NeVjkHrfh8SzP02luQLr9dtcskkUO71jmP5zrwsyWq
	 gn3bMeiopCPKQ==
Date: Mon, 21 Oct 2024 09:47:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dinguyen@kernel.org, marex@denx.de, s.trumtrar@pengutronix.de, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 16/23] dt-bindings: altera: add Enclustra Mercury SA1
Message-ID: <6rqvy23iydi4icdvbqcehhmsyxzp74pcy7c6m4k6iyr5flbhrv@pkzslcqsew6t>
References: <20241020194028.2272371-1-l.rubusch@gmail.com>
 <20241020194028.2272371-17-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241020194028.2272371-17-l.rubusch@gmail.com>

On Sun, Oct 20, 2024 at 07:40:21PM +0000, Lothar Rubusch wrote:
> Update the DT binding for the Enclustra Mercury+ SA1 SoM
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/altera.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


