Return-Path: <linux-kernel+bounces-299942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 378FE95DC99
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 09:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F104C283091
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 07:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A961547F3;
	Sat, 24 Aug 2024 07:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6EpGkmE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13138C148;
	Sat, 24 Aug 2024 07:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724485682; cv=none; b=UqaVD2K0BfvNv8awfr7ZcKj8hXW5DIhmCDLlZXJkiJoA2NCdNJ1rKBGxrYedtIWCJXY931VQNI68q6G2tU+ELHJcgp4RJ4gldhry2NWpSvIrGBbaNokN8ePF+6LMGaSFQiFXz8hXClB0hVB+b3+e2SiR3WvpYb4HYnuXqT7wiGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724485682; c=relaxed/simple;
	bh=bi5zAncYS8UWKYQnurkoZLZOn+W5GvScVd7D3PVw7/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dM1Wo4m+qipVkFItMFXh5iJW0WkwnNGlz8eIfJTP/FoaxlQkSocYXpK4JD140GA0XNCP9LbKoZ4jhlDRthSHclpFrh8FsTBjpTMNDNY8EWOttSAI+SRIuhtPZn/pIrIfc6cc8KqB6cBTkrXG20glCIiKqKqyM2hxkZYgNuC9J6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6EpGkmE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABBBC32781;
	Sat, 24 Aug 2024 07:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724485681;
	bh=bi5zAncYS8UWKYQnurkoZLZOn+W5GvScVd7D3PVw7/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J6EpGkmECO5vLXyRoj7UUjUAOAkD1ITMAPhG5neV6WZhkNcH3OWhSF+byPJUNpnzM
	 pcmCqSjhobBDWCN3FIWa3fpUT+2XyozSQRmsxwWUl+CcmB0CkhHBGS3H3V0lkK8aYQ
	 SP9LwASI9uHfFC51oi1z5aUUNSRwDnCy4oFjhy5HQs4j0vU9t/LaDROTKrZBjJHQD8
	 FYdD66hgXXj3rIGaZrYZz0IrcGanIEHcS7Tdd94zwAml/hw/EOdBuB9VpKRhVBZc6r
	 T6pymXXzj6K8puSGy40ZPYzpjLvsmuaUOXgQbnhpZ0Wkm3H3OES4xMwoXHAqaXggk/
	 8BFneAaGrvr6w==
Date: Sat, 24 Aug 2024 09:47:54 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Michael Walle <michael@walle.cc>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: nvmem: sfp: add ref to
 nvmem-deprecated-cells.yaml
Message-ID: <up4ejmazlgzfzuuhn5gnrlslqvd5xttgk7irdrzjqfvqcti7vg@v5ct3l4zaiq6>
References: <20240821195419.581889-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240821195419.581889-1-Frank.Li@nxp.com>

On Wed, Aug 21, 2024 at 03:54:19PM -0400, Frank Li wrote:
> Add ref nvmem-deprecated-cells.yaml to support old style binding.
> 
> Fix below CHECK_DTBS warning.
> efuse@1e80000: Unevaluated properties are not allowed ('unique-id@1c' was unexpected)
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change from v1 to v2
> - ref to nvmem-deprecated-cells.yaml
> v1: https://lore.kernel.org/imx/20240621165637.2283864-1-Frank.Li@nxp.com/

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


