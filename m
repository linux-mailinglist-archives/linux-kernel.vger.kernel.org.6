Return-Path: <linux-kernel+bounces-392812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 275B29B9868
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAE1E1F22BB7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7A11D0403;
	Fri,  1 Nov 2024 19:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayERHfkA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933191CFEB7;
	Fri,  1 Nov 2024 19:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730489011; cv=none; b=AWCURlqRmqhZcL2yq0yuxxO+m83hdzIX5USygDHwSxn3kwLzVLJlgnyUSqIOL60bcnLW1vAiJ2g0NNQvdBVaorWH9PaphBFGjjvgLbyOyj4dcSOPWT6SDtmYhsHw3rPZw9DieVZulUURMNUrU+eKgSwlPAzIQbXcX7rAdyhCu2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730489011; c=relaxed/simple;
	bh=edLilmCXSRFZ6Hqz0bALeJRUnWZupJsvYQ+69Z3iTCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rl8PltLBMbUdP25K2cQcVP3ISvA3u7gUN6gP7EkktAAcnNGAEWw8LIKHOXbxqXRm8f+AulgL/os8Gk684L6ugX0CFar25b13z9yBW9Cd+KWiDdKJKtJ2XwbHc/7N++pzO67OJ/zv/BD1h1//bs/UCxsfaT1OIMIyRzZDs1l8Si8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayERHfkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E97C4CECD;
	Fri,  1 Nov 2024 19:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730489011;
	bh=edLilmCXSRFZ6Hqz0bALeJRUnWZupJsvYQ+69Z3iTCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ayERHfkAnE/dFF/bIdTk8a1cl4lfc4e0ao0UGLpwZMaX7bWYBBrdv+gVH4Jkhn/0d
	 O3jzr41CaieIJGedy+FaAhPoDrhWMyx2JXK6E1gIJFxmR2ks/1E9vdWttGCilHK5Ek
	 gCRLQfDxf8Bn9HalSDDwUwhD2Q3IzCWBVFcbUI0C9BwysEFQDVDBUfqvFOHN6jrpjg
	 dRt70uJfBAVgfFh/Fmlzq1MjlXwecLByIPTycFzn9izq6AQgsACA2y7BZ7BEZclNlT
	 DgTQ8LjYLEAvJ38Nv2t8Vj4GQTPTIXlCZBzhtH3hAuL7/1w8/ruP6cBG9bVK2k6z3k
	 uPPDUkfjhGk5g==
Date: Fri, 1 Nov 2024 14:23:29 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Mariel Tinaco <Mariel.Tinaco@analog.com>
Cc: linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
	linux-hwmon@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org,
	Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: hwmon: ltc2978: add support for ltc7841
Message-ID: <173048900866.4061911.6642846711506510655.robh@kernel.org>
References: <20241029013734.293024-1-Mariel.Tinaco@analog.com>
 <20241029013734.293024-2-Mariel.Tinaco@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029013734.293024-2-Mariel.Tinaco@analog.com>


On Tue, 29 Oct 2024 09:37:32 +0800, Mariel Tinaco wrote:
> Add LTC7841 to supported devices of LTC2978. It has similar set of
> registers to LTC7880, differing only in number of output channels and
> some unimplemented PMBUS status and functionalities.
> 
> Signed-off-by: Mariel Tinaco <Mariel.Tinaco@analog.com>
> ---
>  Documentation/devicetree/bindings/hwmon/lltc,ltc2978.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


