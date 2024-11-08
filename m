Return-Path: <linux-kernel+bounces-401613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CD29C1CEC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931EA1C21930
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB8C1E7C20;
	Fri,  8 Nov 2024 12:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nk3+Al7p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BD27B3E1;
	Fri,  8 Nov 2024 12:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731068848; cv=none; b=GN6GwA6o1/gBymNrowwxbmZm2iI8gxpMZ7yCgRaKAvFzd2z163UTGUJYluLG4hjFENH8bZxa5dnKhcepladPGGKDSnkc2pOhonbd9Y7C+3UhD56nh8+Gyt1/meGB4BiKfrt/ldK09sWLbKeeltTZuwBsdacKGtKOYhDiZI3GNkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731068848; c=relaxed/simple;
	bh=VJQoN1YcVQJtLA//yK1+saQlRJH8EZXmp3hpluZXlgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ozmsw8huErDyijzukDw9CrpsOB6a5Te1Py44EQwRffN67pPg7NiTIf4lvMBUYVlJoiL6u8V3if5yZBbVWP1/QoDKKkCOK61F8CCMAucIXNnPbgzBXV6nhuTlvR5xV25Lzwq2RNpVGx44vTq1IP8dlV7eNwAcC/ZeA9pwGoK/EOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nk3+Al7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF183C4CECD;
	Fri,  8 Nov 2024 12:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731068846;
	bh=VJQoN1YcVQJtLA//yK1+saQlRJH8EZXmp3hpluZXlgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nk3+Al7pPQkfntj7+HgIjJPTV3IcHoa4IkW4+p5ob4/Es02j4L7K1otGpZrg3EKuy
	 ZhOQ7YceE46J0t3lqJeJP2fvGr1rMpweji/ONWrAI4ddWBPjF404lO45gyOOkGYBrs
	 8WN0I93MN8lmNA7gmuyIFceOwx0b0tUfWexUnPjiD/lvJBwNW+PJaG4U/Toqgt908r
	 4DmLqjk4rosmdTXXR7Z3l7rIriXt7aqFJ/I4cDVnQUoI9txQyswIZkWS1o2/cocrYN
	 F/2G44ZV/GgL55RzuUnM7y3QPYMwMm5umSSXpKc6Y8WN8KEPdW0rKanHVMU+2eCRdf
	 Sb/5xG+karW/g==
Date: Fri, 8 Nov 2024 13:27:23 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com, 
	sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, imx@lists.linux.dev, shengjiu.wang@gmail.com, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: imx93: Add SPDIF IPG clk
Message-ID: <hlnlunxtfs2a2i6gnw7ysws3hrfncyn7whjf4ws2zmw3p3j5a6@itbzs3bzooqs>
References: <20241108100759.682260-1-shengjiu.wang@nxp.com>
 <20241108100759.682260-2-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241108100759.682260-2-shengjiu.wang@nxp.com>

On Fri, Nov 08, 2024 at 06:07:57PM +0800, Shengjiu Wang wrote:
> Add SPDIF IPG clk. The SPDIF IPG clock and root clock
> share same clock gate.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  include/dt-bindings/clock/imx93-clock.h | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


