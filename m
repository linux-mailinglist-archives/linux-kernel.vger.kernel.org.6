Return-Path: <linux-kernel+bounces-375703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0189A99BA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF7882826C0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 06:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDA613BC35;
	Tue, 22 Oct 2024 06:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NE0GrhsN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E20433B0;
	Tue, 22 Oct 2024 06:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729577938; cv=none; b=bQm9Dbdxg8+e1b81/R9HE3XqHsyCWTGm69KVMHmoKfC74hl/VxIfh1CPq5K5IhyU5YVI8DEWTZs5XPMIj98ylnd8fEGxoURa4n622vh5l7NUjVjTKTWQ/o507DaHWNrpX7cQhgCEYP9JNBs26d41UBJUlhuR5IpJd+qWQmTq44U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729577938; c=relaxed/simple;
	bh=9Zz4m5o8MjVThAJP+7kBq+bAHkWCNX6LN7doLoE52j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPEHJuxq/SxRLeK9XcLOQEdemsWr3j8V/U9nK0iU2Fkj9VRKSsfwMcO4DaieUwTL+1z1yP3DC4CLFRZCguDxlttWRy+a0WYNkUS+VDLmGvI0belotwESRTo697CzLC5G6I+SS6GzC8+XyEhwH4/ytkpms0g0m57Tv/cbekeM0P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NE0GrhsN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FB4C4CEC3;
	Tue, 22 Oct 2024 06:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729577937;
	bh=9Zz4m5o8MjVThAJP+7kBq+bAHkWCNX6LN7doLoE52j0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NE0GrhsNu9+OD/21xf45YTba0c9g/tSsqz5+RMkmsg71a+3V79YEcQxT51VmKB5my
	 NSEWcKklAjXaQ/ybvrFmWEtipJpExtl9hrbITGP4H5/5WBECWVlG3mrIfXOjMLy8tH
	 /NYXbEFs3tqadF6Csw8WyHj+C/bv6xcJkG1/UEf6tmGxIsHi8FI0ZYAiDXjVfOdk9+
	 uq0h4+9KtA+NT7hXKd7etFiq9GXEULl+H+ghEiLQNlubS4nxViR6l76Q38uT36EWL1
	 zE3PWsler7LJPKZpSzEf0U+e7AEBNM7pcwGYMhITU4WrJE7nctjZnPWVKprMAgI2L3
	 2NVNBjB6BNf7Q==
Date: Tue, 22 Oct 2024 08:18:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, Trilok Soni <quic_tsoni@quicinc.com>, 
	"Satya Durga Srinivasu Prabhala --cc=linux-arm-msm @ vger . kernel . org" <quic_satyap@quicinc.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] dt-bindings: clock: qcom: Add SM8750 GCC clock
 controller
Message-ID: <qxhsw4sg4feiaee7npio2e7gxi5d2gwsupdculzyhc7xxg6ci2@di532b2jmonc>
References: <20241021230359.2632414-1-quic_molvera@quicinc.com>
 <20241021230359.2632414-5-quic_molvera@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241021230359.2632414-5-quic_molvera@quicinc.com>

On Mon, Oct 21, 2024 at 04:03:56PM -0700, Melody Olvera wrote:
> From: Taniya Das <quic_tdas@quicinc.com>
> 
> Add device tree bindings for the video clock controller on Qualcomm
> SM8750 platform.
> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  .../bindings/clock/qcom,sm8750-gcc.yaml       |  65 +++++
>  include/dt-bindings/clock/qcom,sm8750-gcc.h   | 226 ++++++++++++++++++
>  2 files changed, 291 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8750-gcc.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,sm8750-gcc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8750-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8750-gcc.yaml
> new file mode 100644
> index 000000000000..5e46cccd6e6c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8750-gcc.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,sm8750-gcc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Global Clock & Reset Controller on SM8750
> +
> +maintainers:
> +  - Taniya Das <quic_tdas@quicinc.com>
> +
> +description: |
> +  Qualcomm global clock control module provides the clocks, resets and power
> +  domains on SM8750
> +
> +  See also:: include/dt-bindings/clock/qcom,sm8750-gcc.h
> +
> +properties:
> +  compatible:
> +    const: qcom,sm8750-gcc
> +
> +  clocks:
> +    items:
> +      - description: Board XO source
> +      - description: Board Always On XO source
> +      - description: Sleep clock source
> +      - description: PCIE 0 Pipe clock source
> +      - description: PCIE 1 Pipe clock source
> +      - description: PCIE 1 Phy Auxiliary clock source
> +      - description: UFS Phy Rx symbol 0 clock source
> +      - description: UFS Phy Rx symbol 1 clock source
> +      - description: UFS Phy Tx symbol 0 clock source
> +      - description: USB3 Phy wrapper pipe clock source


It's the same as sm8650, so it should be there. No need for new file.

Best regards,
Krzysztof


