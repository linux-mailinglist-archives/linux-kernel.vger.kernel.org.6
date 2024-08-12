Return-Path: <linux-kernel+bounces-283763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0143194F87C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91EC5B2144F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748BD19DF61;
	Mon, 12 Aug 2024 20:48:21 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773BC19D8B3;
	Mon, 12 Aug 2024 20:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495701; cv=none; b=dhB7xzuQs1vV771Y/zzzGpID424C2NeZx/HHrnV/m6NC5ljLojGNMX+KPVC3jXv7FVANNPv3T95ak8TmYSZ8qkVFlCDOWJG1A2j1TT7BCj3Za23c+T6qYMzUOuv/EQN+E+yhhxrHnClDvufMn+69LXWdviXoB0Dtpnw8YOiD0jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495701; c=relaxed/simple;
	bh=eqTknKWCczSG/9aarHgBE2MVsXXu+t2GvxM4OqPXBMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBiPIDLNXMNosw+VyjDxQ6VtyIRTAkxb46rOzSQ7HdOLoWulqsm7M7zh4pX2iX1hQSRvC3ES5ZfRSd523z8ZPusK4sciUvdu80UBi0sc5H8QogApeyRXv3zgd2UktkbcKBedX9nH8DnEeN0O59wPc+VSTyAnSPgMQsMh6SkOrNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sdbxd-000000001YF-2Wu5;
	Mon, 12 Aug 2024 20:48:13 +0000
Date: Mon, 12 Aug 2024 21:48:09 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org, o.rempel@pengutronix.de
Subject: Re: [PATCH net-next 1/3] net: ag71xx: use devm_clk_get_enabled
Message-ID: <Zrp1CdhNpmK7lcU7@makrotopia.org>
References: <20240812190700.14270-1-rosenp@gmail.com>
 <20240812190700.14270-2-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812190700.14270-2-rosenp@gmail.com>

On Mon, Aug 12, 2024 at 12:06:51PM -0700, Rosen Penev wrote:
> Allows removal of clk_prepare_enable to simplify the code slightly.
> 
> Tested on a TP-LINK Archer C7v2.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>

