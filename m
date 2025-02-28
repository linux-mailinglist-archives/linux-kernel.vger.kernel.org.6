Return-Path: <linux-kernel+bounces-538228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF28A49618
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDF793AFE39
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830EF25A2D8;
	Fri, 28 Feb 2025 09:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="LlhH6219"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E637258CF9;
	Fri, 28 Feb 2025 09:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736552; cv=none; b=DaaptdNFi0gJRoPhA9ymp/21ZpopTYOFZaR6iXTDwhhIhYgJufSr6c3fXgaqBD+eZqsOsQHCTq4ZshJ+Z12mKwylfJCmCF5uVmANGlOanDPgFR0dJaunYikdMJP3d8nySUPSNqdD/FQ1Ib/m3BJ9yOZq+T+z9m64WzNHWCf92LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736552; c=relaxed/simple;
	bh=tNVOhrB27dYY67z3p3+g4+cTL4xqzXotTOz8WDPW1jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEShxOQOmeUB46zoYhIzrN3XWIoH+ANE9trRpJkkFXupw7/TCY95vLPYJ+PjChRmTz0XlpF38SmiIXE5Ic9X3hUHUm774h/SscyZeDZNTiF5c9V6ZrGi/pyciuple7jj9/jr5IbfgZQ8Q6omyNgutv0zfeH4L7mDqh8V96oTCrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=LlhH6219; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id DA92E1FC79;
	Fri, 28 Feb 2025 10:55:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1740736541;
	bh=cH46OOSgHwOcrsTmEvl62W+8vy7UREwxuS3rPqQGW/c=; h=From:To:Subject;
	b=LlhH6219zn1GoFwymXnt7mcFEYsJ0UWvq75dykzDgcV57guXyevGzRMHZR7emmEBY
	 TBHxpwBMq69/INNYcU+UhEDOG7rsRJ9SCHXGYE1PkrGfW3MJwjkZcUB6JCZ8oi8B6Z
	 CPPphU+PJ2DdzpFGLWjeoMuKUkmUKwFp50QL1cOO5dR7dCEXXKJjOnN4AZpudg4HHf
	 CrLw+j7UfAYshsKO7Vys0/0fzhKCezJET9bx8u7B5sPtQ4BtmuCdCJnUjln5lQC7bo
	 hlnQxDXmj1Nvfo2y+wCigz7G+66J4io5kp78P1fWQbQDJHCqVN2Lyx7jzn+O6fwqkL
	 jcPgkjgPEWkOQ==
Date: Fri, 28 Feb 2025 10:55:37 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: apalis/colibri-imx6: Enable STMPE811 TS
Message-ID: <20250228095537.GA16617@francesco-nb>
References: <20250227170556.589668-1-ernest.vanhoecke@toradex.com>
 <20250227170556.589668-2-ernest.vanhoecke@toradex.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227170556.589668-2-ernest.vanhoecke@toradex.com>

On Thu, Feb 27, 2025 at 06:04:52PM +0100, Ernest Van Hoecke wrote:
> Enable the STMPE811 touchscreen in the SOM dtsi files. The STMPE811 is
> part of the SOM. It's self contained within it, therefore, disabling it
> is not the correct default behavior.
> 
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


