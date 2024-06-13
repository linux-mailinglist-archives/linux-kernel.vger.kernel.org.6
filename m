Return-Path: <linux-kernel+bounces-213210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C645907139
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD14AB20FD4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D3D142654;
	Thu, 13 Jun 2024 12:34:43 +0000 (UTC)
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F258B399;
	Thu, 13 Jun 2024 12:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282083; cv=none; b=aHt5OWMe3y1VKiMcQBqbEGoYvhkBx2qWZiUNimnoEMP60ke7bphdcrywuXlYd/DQxgRFGSEdUfr6MqIOmVd4yUh3g8afxUjfeIL1HFxbyeRe3SFR5hbCFEdH3UcI1yZPSl6+wqE6tpux49yMiJWxht0BPbjsvPYqFbnsa7FvWWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282083; c=relaxed/simple;
	bh=QPYhhuD/lOfpknmq6M98eS2of7KIQ5GJXbOk2ppSbp0=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=J2TsBq2rEp2HsakhBn5uXWyq2WAxGQi25bG+iG5uwzfdzIrugIgTaz2jbGotEf1Bx8VfCH8o5IEIn69nrVNnU8hMQP//hSCRWq/oIcJh70AKC0wLwoeWvdKPWol2vVht+C8pJCkyrPH6FbC64qrIOK/o6/ZqXWmJGXkGZyqrzNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=99085fba10=ms@dev.tdt.de>)
	id 1sHjf5-00FOYr-PU; Thu, 13 Jun 2024 14:34:39 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sHjf5-00FOY6-81; Thu, 13 Jun 2024 14:34:39 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id F2282240053;
	Thu, 13 Jun 2024 14:34:38 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 880D5240050;
	Thu, 13 Jun 2024 14:34:38 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 3B51F3852A;
	Thu, 13 Jun 2024 14:34:38 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 13 Jun 2024 14:34:38 +0200
From: Martin Schiller <ms@dev.tdt.de>
To: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 07/12] net: dsa: lantiq_gswip: Use
 dsa_is_cpu_port() in gswip_port_change_mtu()
Organization: TDT AG
In-Reply-To: <20240611135434.3180973-8-ms@dev.tdt.de>
References: <20240611135434.3180973-1-ms@dev.tdt.de>
 <20240611135434.3180973-8-ms@dev.tdt.de>
Message-ID: <731687d5beaa7a6d9fa40cdc83ace829@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1718282079-2CD86746-13F3561F/0/0

On 2024-06-11 15:54, Martin Schiller wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> Make the check for the CPU port in gswip_port_change_mtu() consistent
> with other areas of the driver by using dsa_is_cpu_port().
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  drivers/net/dsa/lantiq_gswip.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/dsa/lantiq_gswip.c 
> b/drivers/net/dsa/lantiq_gswip.c
> index 8ec329d0c136..58c069f964dd 100644
> --- a/drivers/net/dsa/lantiq_gswip.c
> +++ b/drivers/net/dsa/lantiq_gswip.c
> @@ -1464,12 +1464,11 @@ static int gswip_port_max_mtu(struct
> dsa_switch *ds, int port)
>  static int gswip_port_change_mtu(struct dsa_switch *ds, int port, int 
> new_mtu)
>  {
>  	struct gswip_priv *priv = ds->priv;
> -	int cpu_port = priv->hw_info->cpu_port;
> 
>  	/* CPU port always has maximum mtu of user ports, so use it to set
>  	 * switch frame size, including 8 byte special header.
>  	 */
> -	if (port == cpu_port) {
> +	if (dsa_is_cpu_port(ds, port)) {
>  		new_mtu += 8;
>  		gswip_switch_w(priv, VLAN_ETH_HLEN + new_mtu + ETH_FCS_LEN,
>  			       GSWIP_MAC_FLEN);

Signed-off-by: Martin Schiller <ms@dev.tdt.de>

