Return-Path: <linux-kernel+bounces-396124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6111C9BC831
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0931A1F24649
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3061CEAB0;
	Tue,  5 Nov 2024 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="izHqV7Rd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E931C233C;
	Tue,  5 Nov 2024 08:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730796113; cv=none; b=XXwNiVgEz5ve7HcnoYiuiio4HWktdoGDlN00pdF6EkignYo+XonRkTAXQqAqoexEkv9GXCTpxXiOQQZvlVwaA10D8D1xqf96fPFcfw1OTyQsVbVftpatx7v86r1lgNtpMXKfhR14bWX21LUBR4dQ56bYd8mSDcR8mLZFVX3G45U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730796113; c=relaxed/simple;
	bh=lcjUZiRno1Ml7Eu7/D4qbMfW+RtMrSIyM4fBtwM/V5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5YEyE2wcmz9Q+zMgrbjrMHWwXNW1oQgaKqhY7zK7U4x5Nt/ll+7KXU6jFQGhLpBh3QHYpRjQLE7aklp/1UPkF3OZsk1NjfMLy5g4XL4g2+k8WRCKYc+scEpRE5pWbu72TclDAuDS0Bd3txOCKrn2Hz+8W2Sm1meIJu+nowY9dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=izHqV7Rd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A480CC4CECF;
	Tue,  5 Nov 2024 08:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730796113;
	bh=lcjUZiRno1Ml7Eu7/D4qbMfW+RtMrSIyM4fBtwM/V5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=izHqV7RdRft0K8i6MdXxnu9z1rs+gBkcvH/vO/rAOV8A+N905pP/iTkhGfgnYmjYp
	 EhT5KRvfR8lhtWKzLnrCYVTjncgNhQAHpNw8BAiqY2uBdVlLAxp0ZY4rTTYaTsIsDW
	 Q5tg42pDJt9NaZBI57nB5e0u3iSYMc5DE23o9km8=
Date: Tue, 5 Nov 2024 09:41:35 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Haowei Cheng(Harvey)" <harvey.cheng@fibocom.com>
Cc: "chunfeng.yun@mediatek.com" <chunfeng.yun@mediatek.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 0001-usb-mtu3-fix-panic-in-mtu3_gadget_wakeup.patch
Message-ID: <2024110512-popcorn-germless-01be@gregkh>
References: <SEZPR02MB54953820B2A9EEBD807D0ED18E512@SEZPR02MB5495.apcprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEZPR02MB54953820B2A9EEBD807D0ED18E512@SEZPR02MB5495.apcprd02.prod.outlook.com>

On Mon, Nov 04, 2024 at 05:54:43PM +0000, Haowei Cheng(Harvey) wrote:
> 


For some reason you only attached a patch, please send it properly so we
can actually review and apply it if needed.

thanks,

greg k-h

