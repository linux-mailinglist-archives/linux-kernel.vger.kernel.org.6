Return-Path: <linux-kernel+bounces-312478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F04596972B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5785E285082
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F8B2139C8;
	Tue,  3 Sep 2024 08:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AQMa4keX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F562139A7;
	Tue,  3 Sep 2024 08:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725352466; cv=none; b=ixJBTxE5B96RcxkdxTNc5GCqFHh2oM692eSE9nCjRmjAhTDaTyAo5lJuheLEtSCJv46Cod6iun2tcUKCBAzhPQUhhlLj38oZ8amVkeWgwBY+8+5AoGvQK9fYzb7byw6ajD3RCCheU7N29jwTmqQ6qY4mgGMfs/FYTufSUnlmtsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725352466; c=relaxed/simple;
	bh=ut9KFHrZvRyVQkUM0UXLKa+spZHz8fNZOlOjkFwRGkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgW9iTtKgYSmL1Y++z1avsTMvSgO6AqD9b433iGXxh6V86Z++bSzJwKS+ECqstf+H0zvxmJ9LtOzAVBm5Ejn0NB2u+nfUZxM4hZPiJ2YIYzhA2ZRf7MMDQEIvBiBN6DIflvu1i99O+bIEmZ9QSAeuLCItfdUZynNu44s1XPz/7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AQMa4keX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED69C4CECA;
	Tue,  3 Sep 2024 08:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725352464;
	bh=ut9KFHrZvRyVQkUM0UXLKa+spZHz8fNZOlOjkFwRGkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AQMa4keXVTWWxr0+D5hQxBGXm4Rh02BRwxid6MekmMf0kbslGPRlzBQjO+EIPiJ5A
	 jiJh3SObENUNJCVcbHo3ak3RMssGQGHthnrzEQTRSZ1apOOe46Yp5Z77TlDqcij7yh
	 Rb9M0Q+upOmJy3TUs0Up4g0pmsI4DoOFCXNaeH30=
Date: Tue, 3 Sep 2024 10:34:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: Tree Davies <tdavies@darkphysics.net>, anjan@momi.ca,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Staging: rtl8192e: Add spaces around operators.
Message-ID: <2024090307-driven-germproof-03f4@gregkh>
References: <20240830020508.532945-1-tdavies@darkphysics.net>
 <20240830020508.532945-4-tdavies@darkphysics.net>
 <496aa12c-16c2-4050-8f55-caa584116c58@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <496aa12c-16c2-4050-8f55-caa584116c58@gmail.com>

On Fri, Aug 30, 2024 at 09:26:42PM +0200, Philipp Hortmann wrote:
> On 8/30/24 04:05, Tree Davies wrote:
> > Add spaces around arithmetic and bitwise operators to improve
> > readability of the code.
> > 
> > Signed-off-by: Tree Davies <tdavies@darkphysics.net>
> > ---
> >   drivers/staging/rtl8192e/rtllib.h | 62 +++++++++++++++----------------
> >   1 file changed, 31 insertions(+), 31 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
> > index 76f53b797644..17a6fb565c9d 100644
> > --- a/drivers/staging/rtl8192e/rtllib.h
> > +++ b/drivers/staging/rtl8192e/rtllib.h
> > @@ -339,12 +339,12 @@ enum rt_op_mode {
> >   #define	FC_QOS_BIT					BIT(7)
> >   #define is_data_frame(pdu)	(((pdu[0] & 0x0C) == 0x08) ? true : false)
> > -#define	is_legacy_data_frame(pdu)	(is_data_frame(pdu) && (!(pdu[0]&FC_QOS_BIT)))
> > +#define	is_legacy_data_frame(pdu)	(is_data_frame(pdu) && (!(pdu[0] & FC_QOS_BIT)))
> >   #define is_qos_data_frame(pframe)			\
> > -	((*(u16 *)pframe&(IEEE80211_STYPE_QOS_DATA|RTLLIB_FTYPE_DATA)) ==	\
> > -	(IEEE80211_STYPE_QOS_DATA|RTLLIB_FTYPE_DATA))
> > -#define frame_order(pframe)     (*(u16 *)pframe&IEEE80211_FCTL_ORDER)
> > -#define SN_LESS(a, b)		(((a-b)&0x800) != 0)
> > +	((*(u16 *)pframe & (IEEE80211_STYPE_QOS_DATA | RTLLIB_FTYPE_DATA)) ==	\
> > +	(IEEE80211_STYPE_QOS_DATA | RTLLIB_FTYPE_DATA))
> > +#define frame_order(pframe)     (*(u16 *)pframe & IEEE80211_FCTL_ORDER)
> > +#define SN_LESS(a, b)		(((a - b) & 0x800) != 0)
> >   #define SN_EQUAL(a, b)	(a == b)
> >   #define MAX_DEV_ADDR_SIZE 8
> > @@ -414,13 +414,13 @@ enum _REG_PREAMBLE_MODE {
> >   #define WLAN_GET_SEQ_FRAG(seq) ((seq) & RTLLIB_SCTL_FRAG)
> >   #define WLAN_GET_SEQ_SEQ(seq)  (((seq) & RTLLIB_SCTL_SEQ) >> 4)
> > -#define RTLLIB_STATMASK_SIGNAL (1<<0)
> > -#define RTLLIB_STATMASK_RSSI (1<<1)
> > -#define RTLLIB_STATMASK_NOISE (1<<2)
> > +#define RTLLIB_STATMASK_SIGNAL (1 << 0)
> > +#define RTLLIB_STATMASK_RSSI (1 << 1)
> > +#define RTLLIB_STATMASK_NOISE (1 << 2)
> >   #define RTLLIB_STATMASK_WEMASK 0x7
> > -#define RTLLIB_CCK_MODULATION    (1<<0)
> > -#define RTLLIB_OFDM_MODULATION   (1<<1)
> > +#define RTLLIB_CCK_MODULATION    (1 << 0)
> > +#define RTLLIB_OFDM_MODULATION   (1 << 1)
> >   #define RTLLIB_CCK_RATE_LEN		4
> >   #define RTLLIB_CCK_RATE_1MB			0x02
> > @@ -507,11 +507,11 @@ struct rtllib_frag_entry {
> >   struct rtllib_device;
> > -#define SEC_ACTIVE_KEY    (1<<4)
> > -#define SEC_AUTH_MODE     (1<<5)
> > -#define SEC_UNICAST_GROUP (1<<6)
> > -#define SEC_LEVEL	 (1<<7)
> > -#define SEC_ENABLED       (1<<8)
> > +#define SEC_ACTIVE_KEY    (1 << 4)
> > +#define SEC_AUTH_MODE     (1 << 5)
> > +#define SEC_UNICAST_GROUP (1 << 6)
> > +#define SEC_LEVEL	 (1 << 7)
> > +#define SEC_ENABLED       (1 << 8)
> >   #define SEC_LEVEL_0      0 /* None */
> >   #define SEC_LEVEL_1      1 /* WEP 40 and 104 bit */
> > @@ -696,17 +696,17 @@ union frameqos {
> >   #define MAX_WPA_IE_LEN 64
> >   #define MAX_WZC_IE_LEN 256
> > -#define NETWORK_EMPTY_ESSID (1<<0)
> > -#define NETWORK_HAS_OFDM    (1<<1)
> > -#define NETWORK_HAS_CCK     (1<<2)
> > +#define NETWORK_EMPTY_ESSID (1 << 0)
> > +#define NETWORK_HAS_OFDM    (1 << 1)
> > +#define NETWORK_HAS_CCK     (1 << 2)
> >   /* QoS structure */
> > -#define NETWORK_HAS_QOS_PARAMETERS      (1<<3)
> > -#define NETWORK_HAS_QOS_INFORMATION     (1<<4)
> > +#define NETWORK_HAS_QOS_PARAMETERS      (1 << 3)
> > +#define NETWORK_HAS_QOS_INFORMATION     (1 << 4)
> >   #define NETWORK_HAS_QOS_MASK	    (NETWORK_HAS_QOS_PARAMETERS | \
> >   					 NETWORK_HAS_QOS_INFORMATION)
> >   /* 802.11h */
> > -#define NETWORK_HAS_ERP_VALUE	   (1<<10)
> > +#define NETWORK_HAS_ERP_VALUE	   (1 << 10)
> >   #define QOS_QUEUE_NUM		   4
> >   #define QOS_OUI_LEN		     3
> > @@ -996,8 +996,8 @@ enum rtl_link_state {
> >   #define DEFAULT_MAX_SCAN_AGE (15 * HZ)
> >   #define DEFAULT_FTS 2346
> > -#define CFG_RTLLIB_RESERVE_FCS (1<<0)
> > -#define CFG_RTLLIB_COMPUTE_FCS (1<<1)
> > +#define CFG_RTLLIB_RESERVE_FCS (1 << 0)
> > +#define CFG_RTLLIB_COMPUTE_FCS (1 << 1)
> >   struct tx_pending {
> >   	int frag;
> > @@ -1288,7 +1288,7 @@ struct rtllib_device {
> >   	u16 scan_watch_dog;
> >   	/* map of allowed channels. 0 is dummy */
> > -	u8 active_channel_map[MAX_CHANNEL_NUMBER+1];
> > +	u8 active_channel_map[MAX_CHANNEL_NUMBER + 1];
> >   	int rate;       /* current rate */
> >   	int basic_rate;
> > @@ -1486,32 +1486,32 @@ struct rtllib_device {
> >   /* Uses the channel change callback directly
> >    * instead of [start/stop] scan callbacks
> >    */
> > -#define IEEE_SOFTMAC_SCAN (1<<2)
> > +#define IEEE_SOFTMAC_SCAN (1 << 2)
> >   /* Perform authentication and association handshake */
> > -#define IEEE_SOFTMAC_ASSOCIATE (1<<3)
> > +#define IEEE_SOFTMAC_ASSOCIATE (1 << 3)
> >   /* Generate probe requests */
> > -#define IEEE_SOFTMAC_PROBERQ (1<<4)
> > +#define IEEE_SOFTMAC_PROBERQ (1 << 4)
> >   /* Generate response to probe requests */
> > -#define IEEE_SOFTMAC_PROBERS (1<<5)
> > +#define IEEE_SOFTMAC_PROBERS (1 << 5)
> >   /* The ieee802.11 stack will manage the netif queue
> >    * wake/stop for the driver, taking care of 802.11
> >    * fragmentation. See softmac.c for details.
> >    */
> > -#define IEEE_SOFTMAC_TX_QUEUE (1<<7)
> > +#define IEEE_SOFTMAC_TX_QUEUE (1 << 7)
> >   /* Uses only the softmac_data_hard_start_xmit
> >    * even for TX management frames.
> >    */
> > -#define IEEE_SOFTMAC_SINGLE_QUEUE (1<<8)
> > +#define IEEE_SOFTMAC_SINGLE_QUEUE (1 << 8)
> >   /* Generate beacons.  The stack will enqueue beacons
> >    * to the card
> >    */
> > -#define IEEE_SOFTMAC_BEACONS (1<<6)
> > +#define IEEE_SOFTMAC_BEACONS (1 << 6)
> >   static inline void *rtllib_priv(struct net_device *dev)
> >   {
> 
> Hi Tree,
> 
> in many of the above cases checkpatch is asking for using the BIT macro. So
> when you add the spaces to those lines the next change requested by
> ckeckpatch is the BIT macro. I think we should switch only once.
> Find examples below:
> 
> CHECK: Prefer using the BIT macro
> #44: FILE: drivers/staging/rtl8192e/rtllib.h:417:
> +#define RTLLIB_STATMASK_SIGNAL (1 << 0)
> 
> CHECK: Prefer using the BIT macro
> #45: FILE: drivers/staging/rtl8192e/rtllib.h:418:
> +#define RTLLIB_STATMASK_RSSI (1 << 1)
> 
> CHECK: Prefer using the BIT macro
> #46: FILE: drivers/staging/rtl8192e/rtllib.h:419:
> +#define RTLLIB_STATMASK_NOISE (1 << 2)
> 
> CHECK: Prefer using the BIT macro
> #51: FILE: drivers/staging/rtl8192e/rtllib.h:422:
> +#define RTLLIB_CCK_MODULATION    (1 << 0)
> 
> CHECK: Prefer using the BIT macro
> #52: FILE: drivers/staging/rtl8192e/rtllib.h:423:
> +#define RTLLIB_OFDM_MODULATION   (1 << 1)

I'll take this now and then the BIT() conversion can happen later.

thanks,

greg k-h

