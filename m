Return-Path: <linux-kernel+bounces-353559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F42992F73
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BF3E1C212E1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAA51D9A4C;
	Mon,  7 Oct 2024 14:31:02 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573551D9678
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728311461; cv=none; b=fj1zLkQFpzbufb2H5TpmfCeaRtoRvWFyqVQCAFp+NGLwzAZDWoBculWg9eGzbAYXgNYNCNaOD11vPZ/IWelmhtPIoldG2CBN7gLEA99T+aDfB0smo8RE1xWieGjVfpVaEqXrI+TVBD051VwDARKJJHxy5/qeXHr9OjT5A7JpLJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728311461; c=relaxed/simple;
	bh=Nd9+R+kP6/ZMEZeCsskVjMGZ4XQKjXVqgxsSyXWh8k8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y0Gt2uca4q1vCGN6rEChIQul0PWj+QEu8kq9sXE8gljPRwnGikblJywCcwIkv+FeVPkyLBj8V5GK1xc0yA6VUFXZsFfX8HaKdaJCurxXKnqZdTFciBSlRAvkwlsDQiH7XB/EXTVxCpA6QUVXO4wFQqEojNzdh6uZ0BWwI7vBGOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1sxol7-000153-L8; Mon, 07 Oct 2024 16:30:49 +0200
Message-ID: <13350842-4d40-480a-b33d-3f223fca6c63@pengutronix.de>
Date: Mon, 7 Oct 2024 16:30:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] improve multicast join group performance
To: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Madalin Bucur <madalin.bucur@nxp.com>, Sean Anderson <sean.anderson@seco.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de
References: <20241007-igmp-speedup-v1-0-6c0a387890a5@pengutronix.de>
Content-Language: en-US
From: Jonas Rebmann <jre@pengutronix.de>
In-Reply-To: <20241007-igmp-speedup-v1-0-6c0a387890a5@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 07/10/2024 16.17, Jonas Rebmann wrote:
> This series seeks to improve performance on updating igmp group
> memberships such as with IP_ADD_MEMBERSHIP or MCAST_JOIN_SOURCE_GROUP.

Sorry, I forgot: This should have been tagged for net-next. Will be 
fixed in v2.

Regards,
Jonas

-- 
Pengutronix e.K.                           | Jonas Rebmann               |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |

