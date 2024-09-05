Return-Path: <linux-kernel+bounces-316449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E01FC96CFC0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC2F2892F3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 06:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4438A42C0B;
	Thu,  5 Sep 2024 06:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1hPa81X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F58C191F79;
	Thu,  5 Sep 2024 06:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725519010; cv=none; b=Gr1lZKIg2XvmMnoaW2IHArxhOzd8BloyZiF/q+lOdki4yxUQtyeWW6/3Di65nPusyWXuOknfEQNFdrusR1wkZ8Avzj0iIHwuWy+43Mg+nXTIIAjZ3LdUAFHcB5qeWVoY5E5tc/C0Ts3zQXTRJ5AAEBkBTpVBf0/TBplNHbsofCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725519010; c=relaxed/simple;
	bh=x+NxVdAMdu6LVDj01TH+tZKYV4CGqjlkMgUaqOir44w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z++R9MIabi6E5ZKaiYhOrV88UJ7vwwrg/aRGgSlmlaEzQvlzy8dUXOdE6YtOuLeoiIbvyWWcFy50e7FTeH0okmzI4DjcpP8k8snEsZoOVk5hPLAwI1dLncoOTGhXhFBnMwEq+KqvCNHL1alswzIvydKDiqXhSznqtQKYLcE+B4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1hPa81X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A8EC4CEC4;
	Thu,  5 Sep 2024 06:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725519010;
	bh=x+NxVdAMdu6LVDj01TH+tZKYV4CGqjlkMgUaqOir44w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q1hPa81XeUSrGVlvKHbi0BNDsi7o38g+a3VXwQNEsdKeZQXFpOtYl7NOdwSmMg2l3
	 LgVgwvZwAGDRvS/s0RRb0lgIQCbcZ67UlirkVxKj4AS8OHuWMTmUAPZ1eLGPeSP5I1
	 PmH6+QipbLDJKFGqbdJqM1o4+Tsoj/ivuIn3ZTs5PkLAeREEAr0lxYZLYTjZZ9ZmfY
	 5bzxcHCClnxLeazFvCF875NzeF6kFnSDtcdKzU2ghmoZ5Ti3Qz7wp9x5PhazlafENO
	 3cCVgR7Xlfn/2VyrNUQGTqYRvXHzs+HUOCpOd/sV3inkREt00K75s63/IARhlunWfx
	 kawnGa+HeRYsw==
Date: Thu, 5 Sep 2024 08:50:06 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: incomplete-devices: And another batch of
 compatibles
Message-ID: <o4uoinuuj33d5w342ex27aoofjobtsq6m75u67ufyxrmlzyplp@mjwcreewfpiu>
References: <20240904200253.3112699-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240904200253.3112699-1-robh@kernel.org>

On Wed, Sep 04, 2024 at 03:02:52PM -0500, Rob Herring (Arm) wrote:
> Another batch of compatibles unlikely to ever be documented. It's
> mostly old PowerMAC stuff found in DT compatible API calls.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/incomplete-devices.yaml          | 101 ++++++++++++++++++
>  1 file changed, 101 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


