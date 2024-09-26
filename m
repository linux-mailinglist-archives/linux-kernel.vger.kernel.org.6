Return-Path: <linux-kernel+bounces-339962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA64D986CB9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 172A4B22EC5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E6A18C345;
	Thu, 26 Sep 2024 06:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="uwC1nm9r"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0CF188A24;
	Thu, 26 Sep 2024 06:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727333110; cv=none; b=DDvt7NMKT4dmQh5bMyiz8knWSwLF/KelhiqBqQqokBUUN3vBqFZZwBknL9iOAbxsbaXFRGHA0Ox4YZCejsRjKm585xevocRu1+lciIvo3vz7u/jkcEQlD/QDr7hXLxG7Zp7avWZjwsmOjXH9n4ULE8OtFgN5F2mrDKAAZ/MqY3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727333110; c=relaxed/simple;
	bh=hI7MxCsXIaf/DJ2R19U6ihtCmaNvnKryrnUH8gfcTs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cq336snj50LE2l0jTPLlrSCSWXNrgG3hGJIPkzbpoiL9454QVO2W+jHET1oZQP1UiOWHfRI9jd468DQnjC80paDKtqtX1O7LITDuUxNRF2S/HWst2/w7WhDPytHCe8tw3nizvifnupQ3REBPDRyjuAGE3CPtz3EfoekBobYKbn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=uwC1nm9r; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727333083; x=1727937883; i=markus.elfring@web.de;
	bh=td1T6mw4fo/ZEDQgLAOm/azIcVsIehVrPWSwP32/MKc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uwC1nm9rkC+LNYjzZYhs0JFTUAKqxw5/ZThiSPQ8ScTITFaVtUr7QER3m15WipNL
	 eVYrCWjxpL5UDtKXBlqDZeJEGy5Nd2EQwsv7d1MeonrPOR7uLVPBYlB3QfoN9Pv7Q
	 uTNsB4ft0JPp/ne/qyit8i+c9MAgWzJ8eKS1qldqdboSKpxRlrxvT4LgdRYyWxt20
	 U+BtMBYvTTNCEzGBxxeuf7gs3Yc4vw9ot4V7c2KWWqL7gVqYimrBLWrCyhjsrdCrF
	 MQ8+niT8u1U9antnnW0t0wTRKotmXzO5cqBnjxjyyuOpbAIjLDcqDFHGOaAODYVU8
	 hc7oTvOghUrCR9SGNA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mtgyj-1s4VYz447j-00rKLN; Thu, 26
 Sep 2024 08:44:43 +0200
Message-ID: <cbcc0872-1bac-45d2-acfa-920b15225711@web.de>
Date: Thu, 26 Sep 2024 08:44:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: eem: Use common error handling code in
 eem_unwrap()
To: kernel test robot <lkp@intel.com>, linux-usb@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
References: <59fadd5a-6574-4379-98ac-cc4f11b675cc@web.de>
 <202409261347.SAA10KGy-lkp@intel.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <202409261347.SAA10KGy-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bvDn6nDl8JGrelDP5Jvbw5rbFnwNr0pvItKnARmw9bnuKopSgq9
 7kNJyh/enR1RMCKHK3odvXs8pNvELREQW0ri0Da+on1fGgl6TeUS1ZZnNvbQeRSYsIngnpA
 9PP7jG7Gu7t3I45UxXA8QZiuB0yuD/10BAOQ3Klqr2cIxrmIKmrpO5G2NjuHVI3kFiO1/8l
 HiwztrTaeVcOnSuiXDVtA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OwT1nADSO7w=;cSsYFZdCpE40dkT3PWOtVL0hP2K
 /ZwuZyRwWNfTTV8rSgF/Jl5GpGbP5qcoCqy7+wPWZ/4Yeb3SpEa33EYsw8JNcYS0iW8aSpo0i
 rcStmcYkZ/MiiBF2cB2v1rUxbavkQ43rJiaKhrAyQ/AA1oiyVdhl97lzi0d/zH1nbI/MMuGAD
 ejfwk2I4bkaOYQ+zxHhtizXALkApJYuyu+99CWe5xDSOzhzjy6nls5Z4YJTf+tqU63gb5Qcc5
 98p2KIk6q5zHmwiedb4UvXv7RvDKeeg53EVddEFXIyUMGYhe1QUmGM8Csn8f0fSE3dMLhKYl8
 4F7GYnGKDYcazvUFN30exi9ZXxguNF+QCbEld0G8LiNthfs49hNydT18tUnd/iI5R5DeGbVhc
 odHSQS055hOMWwmNp6HGS66PSg1U97tXnfIsJfhHCaAJCfLZm1vNffzk42sDp8wkjij6V3ETk
 3lWQdMi0bXNpTPyXD0n0y43OWgT08CIcBUOEGOJnCWCSpf66JeID1JXr3m/VLeDfHIvZBYLLg
 3bvLVXQXT9zX8Q5HanRsAOXQzWv9TTsd9BETwZ75FlbqHra+z8WZnCZb/iyOg4x4YvesLfVEW
 ClOhKID7ygaIX+jHFH9V3MNAJ/1XMeDmNYyzg4qQgUqPijTMTM93ZxhBJsbNV/nZuFPJwJEyt
 p+1Hh3qNFHdj/rRpqjjclHGJSsgN46mQuCBNNMbR4BJwWAP8k4Ey9AWlqXY4rJO1w9tne80VJ
 LX9rTT+Mp3+H1nd5ZUUGyaZq5HdiEWOzz0SztlMdUzf05KXEQjoiDwH+5YByrXosrxlCGrt1s
 PebXD8PRhq9ayUmIqcgij3xA==

> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on usb/usb-testing]
> [also build test ERROR on usb/usb-next usb/usb-linus westeri-thunderbolt=
/next linus/master v6.11 next-20240925]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Markus-Elfring/us=
b-gadget-eem-Use-common-error-handling-code-in-eem_unwrap/20240925-233931
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git u=
sb-testing
> patch link:    https://lore.kernel.org/r/59fadd5a-6574-4379-98ac-cc4f11b=
675cc%40web.de
> patch subject: [PATCH] usb: gadget: eem: Use common error handling code =
in eem_unwrap()
> config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/2024=
0926/202409261347.SAA10KGy-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 13.3.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arch=
ive/20240926/202409261347.SAA10KGy-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new ver=
sion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409261347.SAA10KGy-lk=
p@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    drivers/usb/gadget/function/f_eem.c: In function 'eem_unwrap':
>>> drivers/usb/gadget/function/f_eem.c:547:29: error: 'ep' undeclared (fi=
rst use in this function); did you mean 'up'?
>      547 |         usb_ep_free_request(ep, req);
>          |                             ^~
>          |                             up
>    drivers/usb/gadget/function/f_eem.c:547:29: note: each undeclared ide=
ntifier is reported only once for each function it appears in
>>> drivers/usb/gadget/function/f_eem.c:547:33: error: 'req' undeclared (f=
irst use in this function); did you mean 'rq'?
>      547 |         usb_ep_free_request(ep, req);
>          |                                 ^~~
>          |                                 rq
>>> drivers/usb/gadget/function/f_eem.c:549:27: error: 'skb2' undeclared (=
first use in this function); did you mean 'skb'?
>      549 |         dev_kfree_skb_any(skb2);
>          |                           ^~~~
>          |                           skb

Is there development support to adjust the scope for mentioned local varia=
bles?


> vim +547 drivers/usb/gadget/function/f_eem.c
>
>    387
>    388	/*
>    389	 * Remove the EEM header.  Note that there can be many EEM packet=
s in a single
>    390	 * USB transfer, so we need to break them out and handle them ind=
ependently.
>    391	 */
>    392	static int eem_unwrap(struct gether *port,
>    393				struct sk_buff *skb,
>    394				struct sk_buff_head *list)
>    395	{
>    396		struct usb_composite_dev	*cdev =3D port->func.config->cdev;
>    397		int				status =3D 0;
>    398
>    399		do {
>    400			struct sk_buff	*skb2;
>    401			u16		header;
>    402			u16		len =3D 0;
>    403
>    404			if (skb->len < EEM_HLEN) {
>    405				status =3D -EINVAL;
>    406				DBG(cdev, "invalid EEM header\n");
>    407				goto error;
>    408			}
>    409
>    410			/* remove the EEM header */
>    411			header =3D get_unaligned_le16(skb->data);
>    412			skb_pull(skb, EEM_HLEN);
>    413
>    414			/* EEM packet header format:
>    415			 * b0..14:	EEM type dependent (data or command)
>    416			 * b15:		bmType (0 =3D=3D data, 1 =3D=3D command)
>    417			 */
>    418			if (header & BIT(15)) {
>    419				struct usb_request	*req;
>    420				struct in_context	*ctx;
>    421				struct usb_ep		*ep;
>    422				u16			bmEEMCmd;
>    423
>    424				/* EEM command packet format:
>    425				 * b0..10:	bmEEMCmdParam
>    426				 * b11..13:	bmEEMCmd
>    427				 * b14:		reserved (must be zero)
>    428				 * b15:		bmType (1 =3D=3D command)
>    429				 */
>    430				if (header & BIT(14))
>    431					continue;
>    432
>    433				bmEEMCmd =3D (header >> 11) & 0x7;
>    434				switch (bmEEMCmd) {
>    435				case 0: /* echo */
>    436					len =3D header & 0x7FF;
>    437					if (skb->len < len) {
>    438						status =3D -EOVERFLOW;
>    439						goto error;
>    440					}
>    441
>    442					skb2 =3D skb_clone(skb, GFP_ATOMIC);
>    443					if (unlikely(!skb2)) {
>    444						DBG(cdev, "EEM echo response error\n");
>    445						goto next;
>    446					}
>    447					skb_trim(skb2, len);
>    448					put_unaligned_le16(BIT(15) | BIT(11) | len,
>    449								skb_push(skb2, 2));
>    450
>    451					ep =3D port->in_ep;
>    452					req =3D usb_ep_alloc_request(ep, GFP_ATOMIC);
>    453					if (!req)
>    454						goto free_skb;
>    455
>    456					req->buf =3D kmalloc(skb2->len, GFP_KERNEL);
>    457					if (!req->buf)
>    458						goto free_request;
>    459
>    460					ctx =3D kmalloc(sizeof(*ctx), GFP_KERNEL);
>    461					if (!ctx) {
>    462						kfree(req->buf);
>    463						goto free_request;
>    464					}
>    465					ctx->skb =3D skb2;
>    466					ctx->ep =3D ep;
>    467
>    468					skb_copy_bits(skb2, 0, req->buf, skb2->len);
>    469					req->length =3D skb2->len;
>    470					req->complete =3D eem_cmd_complete;
>    471					req->zero =3D 1;
>    472					req->context =3D ctx;
>    473					if (usb_ep_queue(port->in_ep, req, GFP_ATOMIC))
>    474						DBG(cdev, "echo response queue fail\n");
>    475					break;
>    476
>    477				case 1:  /* echo response */
>    478				case 2:  /* suspend hint */
>    479				case 3:  /* response hint */
>    480				case 4:  /* response complete hint */
>    481				case 5:  /* tickle */
>    482				default: /* reserved */
>    483					continue;
>    484				}
>    485			} else {
>    486				u32		crc, crc2;
>    487				struct sk_buff	*skb3;
>    488
>    489				/* check for zero-length EEM packet */
>    490				if (header =3D=3D 0)
>    491					continue;
>    492
>    493				/* EEM data packet format:
>    494				 * b0..13:	length of ethernet frame
>    495				 * b14:		bmCRC (0 =3D=3D sentinel, 1 =3D=3D calculated)
>    496				 * b15:		bmType (0 =3D=3D data)
>    497				 */
>    498				len =3D header & 0x3FFF;
>    499				if ((skb->len < len)
>    500						|| (len < (ETH_HLEN + ETH_FCS_LEN))) {
>    501					status =3D -EINVAL;
>    502					goto error;
>    503				}
>    504
>    505				/* validate CRC */
>    506				if (header & BIT(14)) {
>    507					crc =3D get_unaligned_le32(skb->data + len
>    508								- ETH_FCS_LEN);
>    509					crc2 =3D ~crc32_le(~0,
>    510							skb->data, len - ETH_FCS_LEN);
>    511				} else {
>    512					crc =3D get_unaligned_be32(skb->data + len
>    513								- ETH_FCS_LEN);
>    514					crc2 =3D 0xdeadbeef;
>    515				}
>    516				if (crc !=3D crc2) {
>    517					DBG(cdev, "invalid EEM CRC\n");
>    518					goto next;
>    519				}
>    520
>    521				skb2 =3D skb_clone(skb, GFP_ATOMIC);
>    522				if (unlikely(!skb2)) {
>    523					DBG(cdev, "unable to unframe EEM packet\n");
>    524					goto next;
>    525				}
>    526				skb_trim(skb2, len - ETH_FCS_LEN);
>    527
>    528				skb3 =3D skb_copy_expand(skb2,
>    529							NET_IP_ALIGN,
>    530							0,
>    531							GFP_ATOMIC);
>    532				if (unlikely(!skb3))
>    533					goto free_skb;
>    534
>    535				dev_kfree_skb_any(skb2);
>    536				skb_queue_tail(list, skb3);
>    537			}
>    538	next:
>    539			skb_pull(skb, len);
>    540		} while (skb->len);
>    541
>    542	error:
>    543		dev_kfree_skb_any(skb);
>    544		return status;
>    545
>    546	free_request:
>  > 547		usb_ep_free_request(ep, req);
>    548	free_skb:
>  > 549		dev_kfree_skb_any(skb2);
>    550		goto next;
>    551	}
>    552

Would any other software design options become acceptable for the reductio=
n of duplicate statements
(according to resource management)?

Regards,
Markus

