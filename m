Return-Path: <linux-kernel+bounces-383174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 365E39B1811
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 14:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB0D0B22D8C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 12:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAF11D5CE7;
	Sat, 26 Oct 2024 12:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEqwX8w6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6801D7992;
	Sat, 26 Oct 2024 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729945662; cv=none; b=DatSCNgVfsMqUWpTz5QcBlmX6z+ajNioUPOzVHE3s5UcBvKTHsHvwj2sTFBxqqrxymKHdf1xEiT5EOV+oVO1bFAC7N+lMV90cPRqdeMsI8WRZFN+eQF6rZh7MdYe6lLJKSxMXzH7BMSeZd8ZAxmluqHuLxdL3pc1bhUdYXH4wwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729945662; c=relaxed/simple;
	bh=5IAF35CBilkDdfKG2dXqEwD+oT0saedfenXVCy6WnaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYFqd8ziAu5TH7JAXroFpfizbbswH/x09qmg8gDmXpmBKsZvP3RLGwS9gbfm7JBkZIyZC6dMyqRjUaA+Bof1KfmOY1tKKx/q855eCXjyGbuC474Ahz4Q/P6gMmgHom3Wp2f4ixMzUYAnM4jmWkHI2mujj/lvanq+bjaRvSqwSlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEqwX8w6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C73C4CEE5;
	Sat, 26 Oct 2024 12:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729945662;
	bh=5IAF35CBilkDdfKG2dXqEwD+oT0saedfenXVCy6WnaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rEqwX8w6fP/Hw52CBgZm+6BUh6vie5421Zu/ihjke7NKAEyb4jhod/oIxj+AqtzoM
	 KZi3dxyawGAienoflxbxhQEnosMo/X4K3vCiFdt/ohCNcZ5sKWmHiRMp5zdPXBP25S
	 eNKtikAhvCdsO8gO7jrV9FVcqpOqAW5keWoyg6bKiQlttwXS4IT4qk8pWObqWAtxpz
	 hFq6WfXfr7s25T+B6BoEih4YaVUoEhPQ6dLKnTM3/h4TIshuQMd0bKHHK4XW6hU3Qt
	 gVAUsIaFnJdTmap+iTjRNOiV220SCeN0r0ff8mkzeITfuNYZ3HqQybWJ5wQhmsSbYF
	 ioOpGjr9h6Fow==
Date: Sat, 26 Oct 2024 14:27:37 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rouven Czerwinski <r.czerwinski@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@pengutronix.de, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add lxd
Message-ID: <ox6fzzz4mlskruoy7bvse4ui3bwoz7fehl7gq3duypug55ekzu@oc5orv27dhgf>
References: <20241025141130.3179166-1-r.czerwinski@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025141130.3179166-1-r.czerwinski@pengutronix.de>

On Fri, Oct 25, 2024 at 04:11:27PM +0200, Rouven Czerwinski wrote:
> Add vendor prefix for LXD Research & Display, LLC.
> Link: https://www.lxdinc.com/

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


