Return-Path: <linux-kernel+bounces-522639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59766A3CCB3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8CD27A5B74
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A65425B698;
	Wed, 19 Feb 2025 22:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="us79NiLE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C8025A341;
	Wed, 19 Feb 2025 22:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740005625; cv=none; b=uVPUUJxLEI8RMyljoIc+eWl0eHwH/c6pjl9YKwA2dlKPnR3/82fsgjG/IdToNZ0vl+2AZlYPoAT0HISCQDclh31wybzTkmUMQW6fd2z2et1y6jffrXZkk8X1MotQn9ezpcepAEhEZDCVS3G/FhZsLT8ZLjNISUFaJpYbs1RjGzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740005625; c=relaxed/simple;
	bh=qw8qlRg/sKH+mU8xbaUzkQuKzsGCEuW02L8EyLKk/w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkXPEWR96jnirDk5ZP6sqe12NvPEShUfHUGqUvohx3kAgbcYtkmK+7VK0UKI5zjze8HX0bQYfrebMj45DCfYTf+NMW8lzgnsnBgzkiTVCx4kCURzM+8Lu8tbN7aK9tJU4tKQsl+YNuO44tE7ngv5wyp8gO68T39DbPPhwY0L53Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=us79NiLE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E5FC4CED1;
	Wed, 19 Feb 2025 22:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740005624;
	bh=qw8qlRg/sKH+mU8xbaUzkQuKzsGCEuW02L8EyLKk/w4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=us79NiLEbilIoICQcGWo0pOsJ42OEZgwMtAI7ReqKzOgGIZSsVubmpP0sp+8u0fKd
	 fsJpN3VLVS2Ib5+sc5oqv5zOSdH0QGxUJUiTU7NmmgzLv0/EYsjOEqermmbCxyp7nW
	 uzIQFl5nc3DQDtPHI1KzKeqwMsLuMRQPGn5J8eGdyZ4K4Jju4m0aCA3mHHn1z6Wra1
	 zo0TDCvhFjw2xMyMjLs6d/VpD+jphUQC9nSajw38PWQelbxsdZofBSN5dVYCBae+NX
	 AjtBd4r9ISWCkFCwnF+xK4jhWqoDcDqybhMvCYhzW0sU0aR2uoQnO8Ly9Yg73sA7VD
	 ENl4vZ512HHAQ==
Date: Wed, 19 Feb 2025 16:53:42 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: usb-device: Replace free-form 'reg'
 with constraints
Message-ID: <174000562117.3119352.9476901162994430759.robh@kernel.org>
References: <20250214114235.49476-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214114235.49476-1-krzysztof.kozlowski@linaro.org>


On Fri, 14 Feb 2025 12:42:35 +0100, Krzysztof Kozlowski wrote:
> Replace free-form text of 'reg' property with proper constraints so
> incorrect values can be actually reported.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/usb-device.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


