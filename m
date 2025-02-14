Return-Path: <linux-kernel+bounces-514562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D564A3588E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C522F188EC57
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5A122256C;
	Fri, 14 Feb 2025 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJBDnem2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B852E2222C7;
	Fri, 14 Feb 2025 08:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739520727; cv=none; b=WUFuqc1N61oGDcqzcK1i+bAkQ798/xrFI3VU4jMDlYUIiZgJLNvvdtVgnsnaILNbVNuIKCyWyLrjRdX2lUN32/B3PG/RDu6OhqvJycjw9sz8aEOd1IRXyTtQ8otU0FB2P0FpPFO0KkY34UOCOJTuixqpibTeKt7eso4UUXMHsX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739520727; c=relaxed/simple;
	bh=pytx/AVfI7OMUgpHFJaLrLw4szRT5vok7RmUGdfF/YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayVtSdK2+d4trALbcRdOU7oAHBJNNXYggT32gVDlfo91K330guYt4FekdTOvLVM2mjHIHfqXMqnTBTHF4mJjofxEVxSNiTBi7YCivOne5JeiVpH3WyWEiPu/M1gvk/CN+jcG7tsh+FEkW7SfBMsl8Yfi4rLbNtdScJph102d+M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJBDnem2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BDDC4CEDF;
	Fri, 14 Feb 2025 08:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739520727;
	bh=pytx/AVfI7OMUgpHFJaLrLw4szRT5vok7RmUGdfF/YA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hJBDnem2G8p7H0wp7/3KdXqCjJvu7jaaFQK7Ubi6wTIVuEn8a1ZdLVWSpw8+3irLg
	 g/0geKZxhvomJAW9EQVE29Oz1SaktEFzJYwu+qiXXqu5/ut/cOLUSVxQIhM8Zs6sCw
	 YWcShuIrnVfL7arjQmuljE9XEli5QDAsReYLIvm47IAfiBVu5h7o7+Fuc876AK5xXy
	 ETS/F54s5TPzmdJ8Vy8WWoa8Wc6XbgSOKBD/UBJOXgoozaSHbIpklaA/LAWC+z7udo
	 gcVRWSzU5zx+QqoTZLA4A/4Eid/8FYQBEkIibgs9oY9+pzgbFfV+vjl0ZwE9gSfXtz
	 PkTzdeC8mMGlA==
Date: Fri, 14 Feb 2025 09:12:03 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 2/8] dt-bindings: arm: Add Morello fvp compatibility
Message-ID: <20250214-utopian-griffin-of-innovation-fabc40@krzk-bin>
References: <20250213180309.485528-1-vincenzo.frascino@arm.com>
 <20250213180309.485528-3-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250213180309.485528-3-vincenzo.frascino@arm.com>

On Thu, Feb 13, 2025 at 06:03:03PM +0000, Vincenzo Frascino wrote:
> Add compatibility to Arm Morello Fixed Virtual Platform.
> 
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/arm,vexpress-juno.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/arm,vexpress-juno.yaml b/Documentation/devicetree/bindings/arm/arm,vexpress-juno.yaml
> index 40e7910756c8..e71e3e33c4be 100644
> --- a/Documentation/devicetree/bindings/arm/arm,vexpress-juno.yaml
> +++ b/Documentation/devicetree/bindings/arm/arm,vexpress-juno.yaml
> @@ -122,6 +122,10 @@ properties:
>          items:
>            - const: arm,morello-sdp

That's just part of the enum here.

>            - const: arm,morello
> +      - description: Arm Morello Fixed Virtual Platform
> +        items:
> +          - const: arm,morello-fvp

Best regards,
Krzysztof


