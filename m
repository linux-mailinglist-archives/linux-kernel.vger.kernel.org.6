Return-Path: <linux-kernel+bounces-339903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81960986C04
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1F461C21804
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 05:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC86D17B4FA;
	Thu, 26 Sep 2024 05:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NVjS7STC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C054D3F9CC;
	Thu, 26 Sep 2024 05:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727328480; cv=none; b=Pwtznv9I+W2RUnQ+9ZokEoEKYR5c0iTZCiJ8RgsXM97YBhvJ/loRamfP/MKHwwuBAKO17EreLVOhpavfnHU5MsWDIr9VKg4IPFGxWTRVUPwdh0CK/+XjmWGSLZ/L2oYRLPt7M/HPsTL1/cOiviVdiUNBB28hAFTvMuw0zuowJng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727328480; c=relaxed/simple;
	bh=UZrozBDYdMFb6UkXa6vjz0Wz5g4rgUzLenkJ5QXRK7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsNl0L4tfxZsOgOgD3Vh9OhBGivOOG2Hwg80n8uXAOj1ysTJykN6BiDKLwhBU3ObuMvKBpgZID0cdVF+5S6A73VWa5mQmLoVsx9uuV1gRC2CCzJIeDu4YEvYC+JlhMBakQa6BfLEQ8kKZbsxUZBWJDIImMQglbknbSYLPJiNpfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NVjS7STC; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727328477; x=1758864477;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UZrozBDYdMFb6UkXa6vjz0Wz5g4rgUzLenkJ5QXRK7E=;
  b=NVjS7STC2q6Xz0nG3aqwBaEPGbQu7L5hZDK+eRWl2jFG2Hn+CHg7DnMC
   3gZ9z5Mz4z5ujJh56rkv/brb6RjOfWkvNjkAr/UMIxdhewJOgG9h5wZyy
   VE1ejl5XeqxWLYG7R0BEO9A9tl9VtK5aN90FEm1KqT3Nym/NcORSUYZST
   CNvAiR2mpagczor2zO91JTqvtvBMIIKScYddKizPQgsjVU8N+5R1WwqJE
   PVVSgxgkgZBcfVLCxVNY00GrsEhILaTbnlrzfVzCMfUO+scu0S0B1rmVc
   by6+oXADvHM3vEGMsJ+L0YcLd2j28TBHLPBI+dbNZYBoKe6fvMFrDQvy4
   w==;
X-CSE-ConnectionGUID: 7xtt1ziDTACVFPoqkwxMzQ==
X-CSE-MsgGUID: RZSrn32aRNuXuYEJu76ung==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="14028229"
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; 
   d="scan'208";a="14028229"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 22:27:57 -0700
X-CSE-ConnectionGUID: lrVoUYroTYufgzsTY6ujiA==
X-CSE-MsgGUID: zAWN2WwxRBChuSnszzEvJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; 
   d="scan'208";a="72016304"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 25 Sep 2024 22:27:55 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sth2f-000KIt-0J;
	Thu, 26 Sep 2024 05:27:53 +0000
Date: Thu, 26 Sep 2024 13:27:11 +0800
From: kernel test robot <lkp@intel.com>
To: Markus Elfring <Markus.Elfring@web.de>, linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: eem: Use common error handling code in
 eem_unwrap()
Message-ID: <202409261347.SAA10KGy-lkp@intel.com>
References: <59fadd5a-6574-4379-98ac-cc4f11b675cc@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59fadd5a-6574-4379-98ac-cc4f11b675cc@web.de>

Hi Markus,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus westeri-thunderbolt/next linus/master v6.11 next-20240925]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Markus-Elfring/usb-gadget-eem-Use-common-error-handling-code-in-eem_unwrap/20240925-233931
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/59fadd5a-6574-4379-98ac-cc4f11b675cc%40web.de
patch subject: [PATCH] usb: gadget: eem: Use common error handling code in eem_unwrap()
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240926/202409261347.SAA10KGy-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240926/202409261347.SAA10KGy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409261347.SAA10KGy-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/usb/gadget/function/f_eem.c: In function 'eem_unwrap':
>> drivers/usb/gadget/function/f_eem.c:547:29: error: 'ep' undeclared (first use in this function); did you mean 'up'?
     547 |         usb_ep_free_request(ep, req);
         |                             ^~
         |                             up
   drivers/usb/gadget/function/f_eem.c:547:29: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/usb/gadget/function/f_eem.c:547:33: error: 'req' undeclared (first use in this function); did you mean 'rq'?
     547 |         usb_ep_free_request(ep, req);
         |                                 ^~~
         |                                 rq
>> drivers/usb/gadget/function/f_eem.c:549:27: error: 'skb2' undeclared (first use in this function); did you mean 'skb'?
     549 |         dev_kfree_skb_any(skb2);
         |                           ^~~~
         |                           skb


vim +547 drivers/usb/gadget/function/f_eem.c

   387	
   388	/*
   389	 * Remove the EEM header.  Note that there can be many EEM packets in a single
   390	 * USB transfer, so we need to break them out and handle them independently.
   391	 */
   392	static int eem_unwrap(struct gether *port,
   393				struct sk_buff *skb,
   394				struct sk_buff_head *list)
   395	{
   396		struct usb_composite_dev	*cdev = port->func.config->cdev;
   397		int				status = 0;
   398	
   399		do {
   400			struct sk_buff	*skb2;
   401			u16		header;
   402			u16		len = 0;
   403	
   404			if (skb->len < EEM_HLEN) {
   405				status = -EINVAL;
   406				DBG(cdev, "invalid EEM header\n");
   407				goto error;
   408			}
   409	
   410			/* remove the EEM header */
   411			header = get_unaligned_le16(skb->data);
   412			skb_pull(skb, EEM_HLEN);
   413	
   414			/* EEM packet header format:
   415			 * b0..14:	EEM type dependent (data or command)
   416			 * b15:		bmType (0 == data, 1 == command)
   417			 */
   418			if (header & BIT(15)) {
   419				struct usb_request	*req;
   420				struct in_context	*ctx;
   421				struct usb_ep		*ep;
   422				u16			bmEEMCmd;
   423	
   424				/* EEM command packet format:
   425				 * b0..10:	bmEEMCmdParam
   426				 * b11..13:	bmEEMCmd
   427				 * b14:		reserved (must be zero)
   428				 * b15:		bmType (1 == command)
   429				 */
   430				if (header & BIT(14))
   431					continue;
   432	
   433				bmEEMCmd = (header >> 11) & 0x7;
   434				switch (bmEEMCmd) {
   435				case 0: /* echo */
   436					len = header & 0x7FF;
   437					if (skb->len < len) {
   438						status = -EOVERFLOW;
   439						goto error;
   440					}
   441	
   442					skb2 = skb_clone(skb, GFP_ATOMIC);
   443					if (unlikely(!skb2)) {
   444						DBG(cdev, "EEM echo response error\n");
   445						goto next;
   446					}
   447					skb_trim(skb2, len);
   448					put_unaligned_le16(BIT(15) | BIT(11) | len,
   449								skb_push(skb2, 2));
   450	
   451					ep = port->in_ep;
   452					req = usb_ep_alloc_request(ep, GFP_ATOMIC);
   453					if (!req)
   454						goto free_skb;
   455	
   456					req->buf = kmalloc(skb2->len, GFP_KERNEL);
   457					if (!req->buf)
   458						goto free_request;
   459	
   460					ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
   461					if (!ctx) {
   462						kfree(req->buf);
   463						goto free_request;
   464					}
   465					ctx->skb = skb2;
   466					ctx->ep = ep;
   467	
   468					skb_copy_bits(skb2, 0, req->buf, skb2->len);
   469					req->length = skb2->len;
   470					req->complete = eem_cmd_complete;
   471					req->zero = 1;
   472					req->context = ctx;
   473					if (usb_ep_queue(port->in_ep, req, GFP_ATOMIC))
   474						DBG(cdev, "echo response queue fail\n");
   475					break;
   476	
   477				case 1:  /* echo response */
   478				case 2:  /* suspend hint */
   479				case 3:  /* response hint */
   480				case 4:  /* response complete hint */
   481				case 5:  /* tickle */
   482				default: /* reserved */
   483					continue;
   484				}
   485			} else {
   486				u32		crc, crc2;
   487				struct sk_buff	*skb3;
   488	
   489				/* check for zero-length EEM packet */
   490				if (header == 0)
   491					continue;
   492	
   493				/* EEM data packet format:
   494				 * b0..13:	length of ethernet frame
   495				 * b14:		bmCRC (0 == sentinel, 1 == calculated)
   496				 * b15:		bmType (0 == data)
   497				 */
   498				len = header & 0x3FFF;
   499				if ((skb->len < len)
   500						|| (len < (ETH_HLEN + ETH_FCS_LEN))) {
   501					status = -EINVAL;
   502					goto error;
   503				}
   504	
   505				/* validate CRC */
   506				if (header & BIT(14)) {
   507					crc = get_unaligned_le32(skb->data + len
   508								- ETH_FCS_LEN);
   509					crc2 = ~crc32_le(~0,
   510							skb->data, len - ETH_FCS_LEN);
   511				} else {
   512					crc = get_unaligned_be32(skb->data + len
   513								- ETH_FCS_LEN);
   514					crc2 = 0xdeadbeef;
   515				}
   516				if (crc != crc2) {
   517					DBG(cdev, "invalid EEM CRC\n");
   518					goto next;
   519				}
   520	
   521				skb2 = skb_clone(skb, GFP_ATOMIC);
   522				if (unlikely(!skb2)) {
   523					DBG(cdev, "unable to unframe EEM packet\n");
   524					goto next;
   525				}
   526				skb_trim(skb2, len - ETH_FCS_LEN);
   527	
   528				skb3 = skb_copy_expand(skb2,
   529							NET_IP_ALIGN,
   530							0,
   531							GFP_ATOMIC);
   532				if (unlikely(!skb3))
   533					goto free_skb;
   534	
   535				dev_kfree_skb_any(skb2);
   536				skb_queue_tail(list, skb3);
   537			}
   538	next:
   539			skb_pull(skb, len);
   540		} while (skb->len);
   541	
   542	error:
   543		dev_kfree_skb_any(skb);
   544		return status;
   545	
   546	free_request:
 > 547		usb_ep_free_request(ep, req);
   548	free_skb:
 > 549		dev_kfree_skb_any(skb2);
   550		goto next;
   551	}
   552	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

