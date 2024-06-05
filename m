Return-Path: <linux-kernel+bounces-203410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 285138FDA88
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEFF91F26294
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E70167265;
	Wed,  5 Jun 2024 23:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVnyQJzC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5233C28;
	Wed,  5 Jun 2024 23:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717630270; cv=none; b=ryOs5TIAta/i3+xvZvFIyCwTFFnf3ZvQflHwRUKAB3WfWQJ4ls/gsIFY/G75wYbFABOvhcZH0y06yh38BHaSTNVkvbuAw4O1aTXDCScG9FnMjanUs8hR/sTb396XYozcalZqA1BTG6xUQp2ZhV4iMOnYfyBWJH2Mrz5Ql+HIHvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717630270; c=relaxed/simple;
	bh=IKfl9A1hYYsSjd2SXNKisKTsjeE3DENdygs00bdD1VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDrvz6dXNx3Hr+b8JcopY7QMYHzsASDlumehJJ+eUurd93qnUso8N0kQsQ+P66Yr8aiYckVsyj9ueNVEa1G7AWXu7miiOGJhvNq2+sTQyd1NG7hWa+YGTJizh3w+WdbJySw6ugDBq7iH9Y2rkkm1UVlCRRb+zx7ZG3yix7MzUOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVnyQJzC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF58CC2BD11;
	Wed,  5 Jun 2024 23:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717630270;
	bh=IKfl9A1hYYsSjd2SXNKisKTsjeE3DENdygs00bdD1VM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eVnyQJzCCpl93uzNMNF9luwC9SJDsc3b42JYhbuUmcX0EUPN0P/UbDLnzjXwaByyC
	 TLUy6Wbm2NoscZsnPyjUmJVF/22/tU27opqTvmE6rsOAmTvgXkadqLX5ukEboV+2o4
	 Ivj4EjJJ2mGvtp9wSC394XiQR/kKBkdzSehGquO0EDK8YDeTDDoaCu9odTiEmOT0LB
	 SpDI1drfCD0laycNnKy7G44MMTdEXYtOm0iMiLIZgzjODiu2HVJBhRQWCBxGbpsH5P
	 I9fHgAcm8lhLNPbfqHWORG8lRzAYSpnWn65GIY5X68yORlsA/WoSfAWPiZti8FzCoE
	 cYNpiHceFExcQ==
Date: Wed, 5 Jun 2024 17:31:07 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Amna Waseem <Amna.Waseem@axis.com>
Cc: linux-hwmon@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
	kernel@axis.com, Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: hwmon: ti,ina2xx: Add
 ti,alert-polarity-active-high property
Message-ID: <171763026528.3434304.6822846503927311344.robh@kernel.org>
References: <20240603-apol-ina2xx-fix-v3-0-b9eff3158e4e@axis.com>
 <20240603-apol-ina2xx-fix-v3-1-b9eff3158e4e@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603-apol-ina2xx-fix-v3-1-b9eff3158e4e@axis.com>


On Mon, 03 Jun 2024 12:08:34 +0200, Amna Waseem wrote:
> Add a property to the binding to configure the Alert Polarity.
> Alert pin is asserted based on the value of Alert Polarity bit of
> Mask/Enable register. It is by default 0 which means Alert pin is
> configured to be active low open collector. Value of 1 maps to
> Inverted (active high open collector).
> 
> Signed-off-by: Amna Waseem <Amna.Waseem@axis.com>
> ---
>  Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


