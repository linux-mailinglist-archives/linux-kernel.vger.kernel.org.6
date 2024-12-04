Return-Path: <linux-kernel+bounces-430788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 646C69E360B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26B9FB27AD0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29EB196455;
	Wed,  4 Dec 2024 08:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQ0wZyK6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3275918C03B;
	Wed,  4 Dec 2024 08:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733301507; cv=none; b=mpPCw+JAU2yQLkqtRX8dJTWJz03uWzJhwV4L0vqjzI4GX49+PiaXjk7Wqgl/0H/hyWVRNxmFod41b5SXp8kqmfszUg9cvRTL/Is6WFqkgps0mW5kqkI67/9/I+HYW6RynWi+0sT2eIEs344UaNXgCz63Vg6uckd82lQog1A5AO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733301507; c=relaxed/simple;
	bh=qyu4sdJIZE8YG6rqCb7uR8DZa3zsLilFXXQte5W71Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2vyXEb56F9/kNKg6FSFHKjd+VXjQl7F2NcHKqracShCAoFn4xORDIVPP7nbwMC+eHTJGLtijSka9coHllXZvkT+XfeckJPSGH4stVQQdutKRyPFQqnm9GeKtHUpVzDHpOyJMQF22Hu+0hdiaYsnnjE5kINGeYJPtfsYu+r9Vb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQ0wZyK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB276C4CED6;
	Wed,  4 Dec 2024 08:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733301506;
	bh=qyu4sdJIZE8YG6rqCb7uR8DZa3zsLilFXXQte5W71Y8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nQ0wZyK6Er4GCW/x4pOB1Ffy0HNXP+XICFbzET0oRoBpt4FU8X/+OUUtlnnaHtrzg
	 /Mdwdd0AavZXy4ptwgpYPh7nPyfGVzgH7xMTizhdmolotE1PKaqYLHFsI6am5kx9pl
	 mSPUzx775CXor3wN9oKhvHFPBdSMAjLMfIfNdU6Kjlhxb9EGEq4Efgu+wz6Qw3yGMk
	 Gbz/8PhTpNU9O5kabC7BQ1pDZL4bUenwgIgfjjsnJcI67wLkbJ8cy/s4VsUpYyVns3
	 mH9flRBYJHGgNQ7cXNAVojfGNN8iQvtxgGntp/NlG2SQlXbcL/TB1IjT24rQX+/tMC
	 9Pr7ZVC2oDGyg==
Date: Wed, 4 Dec 2024 09:38:22 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andrew Davis <afd@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: mfd: syscon: Add ti,am654-icssg-ctrl
 compatible
Message-ID: <ii7dbehl2ecvgc6e4kqy5nk2e22hnbk43tldqfxjk7xxapnp5x@7ojnf36ej3fm>
References: <20241203173113.90009-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241203173113.90009-1-afd@ti.com>

On Tue, Dec 03, 2024 at 11:31:10AM -0600, Andrew Davis wrote:
> Add TI ICSSG control registers compatible. This is a region found in the
> TI AM65 CTRL_MMR0 register space[0]. Each instance is used to control a
> an ICSSG's RGMII delay and GPO mode.
> 
> [0] https://www.ti.com/lit/pdf/spruid7
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index b414de4fa779b..34943d9fc0ab5 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -115,6 +115,7 @@ select:
>            - ti,am625-dss-oldi-io-ctrl
>            - ti,am62p-cpsw-mac-efuse
>            - ti,am654-dss-oldi-io-ctrl
> +          - ti,am654-icssg-ctrl

Considering your patch #2 adding something with similar name, this is
quite confusing.

Anyway, where is any user of this? If there is no user, then why? If
there is, then commit msg should explain that you document existing
device.

Best regards,
Krzysztof


