Return-Path: <linux-kernel+bounces-511664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8D4A32DFE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98BAF163098
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688C525D521;
	Wed, 12 Feb 2025 17:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXZsyfQW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B994B2586C6;
	Wed, 12 Feb 2025 17:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739383034; cv=none; b=FQ6Ed6BFvetfP5Yivliyw/0xd50mx43+p6RP9r5DKPGy+mvEO2pRnxEGLXjFHnCWy9mzGK4MF1XUcGPukycWtXvnyRox1PsklZx5310QDy6dIBa8uYMo5ixC9JQquDHtkisArSbcXZk7cIMkQaEGmWnIsCyLJV2h34oBA2327Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739383034; c=relaxed/simple;
	bh=cK+PJN2rWgsqW47Djf1d/0Ua8acL+IoX8Ek8gmB1a4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPidRtY/y63WDgyKkCxxvPYTnelCPC6Gs9dhAWLASExuwHQ72HRhlVFKD8BgAv0ov4OE111/LgCA2EuxPObQBfWkQB2xZaxOXjEaYyXIBymqOXSPB85wCkPpzY3l2cyyxzT1PzQSysFund+A7ZQbsrNFoLZ9+CFiSxWzR2YvgXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXZsyfQW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23C5C4CEDF;
	Wed, 12 Feb 2025 17:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739383034;
	bh=cK+PJN2rWgsqW47Djf1d/0Ua8acL+IoX8Ek8gmB1a4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iXZsyfQWZj4aB9Mnt58Bz6IKcmXgQeXwSb1MhLGH9BtULIaFpqQIAIMYc8Dhlx3o8
	 X9wSfFK+wWXV5be8j/0jYanRVR11Lgupg1ZCoUMDSznpR2KS7OroiF9Kr6iJoJUxlA
	 nYQocyYHRvGn4tJ3pOKfc3hr0R87OLsb59kMD/nCXqeN7y7KjFf/OB9DfsFZ7oipa7
	 QnLJjZSpA9IlwL8JIsT+a3h9Db+ebLbaApN1X9N36X+ti/TnDJaA0XCuUDTCsZrSwh
	 9pxULRYHRExD24Je2CLiFvXnmH13p/RsllLQYS8+nhVfJ9hOpK21Fr1BM+aHfM8VM1
	 hRvvB6pX8t3Iw==
Date: Wed, 12 Feb 2025 11:57:13 -0600
From: Rob Herring <robh@kernel.org>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Guenter Roeck <linux@roeck-us.net>, broonie@kernel.org,
	conor@kernel.org, Jean Delvare <jdelvare@suse.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: ir38060: Move & update dt binding
Message-ID: <20250212175713.GA4032715-robh@kernel.org>
References: <20250207132806.3113268-1-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207132806.3113268-1-naresh.solanki@9elements.com>

On Fri, Feb 07, 2025 at 06:58:03PM +0530, Naresh Solanki wrote:
> Move dt binding under hwmon/pmbus & align accordingly.
> 
> Previously the DT binding was invalid & wouldn't work with pmbus driver.
> Pmbus driver expects a regulator node & hence added the same.

2 out of 3 (schema, dts, driver) agree. Fix the driver.

> 
> Fixes: 1d333cd641fb ("ARM: dts: aspeed: sbp1: IBM sbp1 BMC board")
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> ---
> Changes in V2:
> 1. Update commit message
> 2. Add Fixes tags
> ---
>  .../hwmon/pmbus/infineon,ir38060.yaml         | 61 +++++++++++++++++++
>  .../bindings/regulator/infineon,ir38060.yaml  | 45 --------------
>  2 files changed, 61 insertions(+), 45 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/infineon,ir38060.yaml
>  delete mode 100644 Documentation/devicetree/bindings/regulator/infineon,ir38060.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/infineon,ir38060.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,ir38060.yaml
> new file mode 100644
> index 000000000000..e1f683846a54
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,ir38060.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/pmbus/infineon,ir38060.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Infineon Buck Regulators with PMBUS interfaces
> +
> +maintainers:
> +  - Not Me.

Nothing new here, but WTF. Expect a meta-schema change to warn on this.

Rob

