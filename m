Return-Path: <linux-kernel+bounces-369423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 862239A1D20
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FEEC1F27608
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBB81D0DE7;
	Thu, 17 Oct 2024 08:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlQvoPzC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869BA25776;
	Thu, 17 Oct 2024 08:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729153521; cv=none; b=qIuOfB8jB4eDZtSwbmG05/FJr5RXvdU4QSrXCHCqoEEcB5ThS/wfqIKqJDa0wu6jewaMmyf4sePjVtRZzLkoIVQKGa2LiAhizeXf6JDSBClg5rchuJd5JqhwCgi+vcPTA7Ub/E7OChlR16jIdoX8YFhViKvJdp39bK8ux01GLOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729153521; c=relaxed/simple;
	bh=YeULyc+3Ph2hXlDNQU9iVFA/aPzsu6x6KOxmcinVGnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YeGgZ1tV0ZvRsZF4SNTgNCuDiLYxmKCJRc6oWyKB0l4z9MXoAwM6pntLkh9TSejbvSMvygnGKMD/dY+eA1QZLxqQ2nrF+/6nMl0XhO+/5rNbXNAtmtNyeExR4lsdnRakHELBxB9W5LbVxt3eGjdSRfcFwGt2pW3QQ02tOHBiE5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlQvoPzC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F459C4CEC7;
	Thu, 17 Oct 2024 08:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729153520;
	bh=YeULyc+3Ph2hXlDNQU9iVFA/aPzsu6x6KOxmcinVGnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RlQvoPzCbrbfwzOqsxlUd3ohwVe/tSOQne3oBXZGnb6l0i+RXDjTNfVi8u8aiHb6f
	 StkxUt8ecd7PxrBxy5APFG2d7f+ttE3GxFrGuXGRS1ajiFn7WHRqO7YYtDdl5xTUHi
	 85Mu4mOwrolw5V8Ne3AM2n/oRWKh+OGiPAA8LVgZFCFb4h5l7gnY9dKmYYGahlvJLN
	 8M759CjjsFsQesEOpuC3I5/XWPox33hXdXFK+urA+L3zqTWZ8YTNwAT+ZtRwmbVdJM
	 +0ErTazvkYwbDH1v827XjJXqPmW5oJuTheCjE2adlVPVuQtuZcZhDJKuvtlC0rut+p
	 8MybMupGrhOpA==
Date: Thu, 17 Oct 2024 10:25:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Wang <frawang.cn@gmail.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, william.wu@rock-chips.com, 
	tim.chen@rock-chips.com, yubing.zhang@rock-chips.com, 
	Frank Wang <frank.wang@rock-chips.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: soc: rockchip: add rk3576 vo1-grf
 syscon
Message-ID: <uple657y7t77ppm7qbvu5xzixu6xkukq2nkobrej6om32xyc6f@tnadbw5uliaf>
References: <20241017025230.28752-1-frawang.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241017025230.28752-1-frawang.cn@gmail.com>

On Thu, Oct 17, 2024 at 10:52:28AM +0800, Frank Wang wrote:
> From: Frank Wang <frank.wang@rock-chips.com>
> 
> Add rockchip,rk3576-vo1-grf syscon compatible, the vo1-grf is
> configured in usbdp phy driver.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> ---
> Changelog:
> v2:
>  - This is a new patch adds rk3576-vo1-grf syscon.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


