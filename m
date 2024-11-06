Return-Path: <linux-kernel+bounces-398346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFF99BEFE6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 669DD1F23F9E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C1B2022DA;
	Wed,  6 Nov 2024 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNuKbhnl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0892010E6;
	Wed,  6 Nov 2024 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730902491; cv=none; b=ZmcNioKPQyULvSFDuGCKmTM5VTa+gTRq7zGSg6/BTaKR0BPRKN6WhqfIy47vUxEJ2Za+w+d97+xwsFoSUrRirsofzn9oXRJdcNJpIyY/2CCxYM593PHbHCGuA45Cs/VxFlNSFlbo0Iw7wpghu+yGG7CntNeNFmfd0djujT7qj8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730902491; c=relaxed/simple;
	bh=LZgHMglaalJFPre4ZauInW/LgNM368v+S2B0ogkJf9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLe7FbCBYtK4ODggflyuInu+td+HxMHW2CAAvPtZYQctXuUNpDPx+bkZ4q1EsshtITHQ1Ze2mYOpH3k03j4Hr3/bFFjn09E6Lxil/kDD/4RTPZ+WUhCmNQkle02p7mBzDYn4Bqt8WRwixABK6Oe56BTvd2PL2ZGIwN53RkDZRH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNuKbhnl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ACB4C4CEC6;
	Wed,  6 Nov 2024 14:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730902491;
	bh=LZgHMglaalJFPre4ZauInW/LgNM368v+S2B0ogkJf9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TNuKbhnl33A/7cQ6fUGWx9jFuMxtGTw4Co8GXtGrC5josJ9S2RIv7GXLd1ongEOBl
	 9rUY2rUrftyuExrtEm3v7geh3Q/4tPI0BVy32Axyx57RsLrV9a5D//OUT97t9ysJFB
	 1nb+RLg1m1LrVdng+C2OjHKg7K3PwHiDIoodyPzP+WhAiaFhDBqwrJf/3GFKHgeQen
	 G0WSKEh2R5+dYHMv5gV2kl7iOhDkIsem8nqEklhO+4QwH+oPvu2JtDd6ONib65iKdf
	 B6w4KETUgl/m861wDsXMCBE32XAB8/hhE7hUjb2zEOJYyMIEw8s9XxX/RJKopVoCny
	 7xD6SgWkG1xpw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t8go7-000000005Nt-1yfT;
	Wed, 06 Nov 2024 15:14:52 +0100
Date: Wed, 6 Nov 2024 15:14:51 +0100
From: Johan Hovold <johan@kernel.org>
To: wojackbb@gmail.com
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v3]USB: serial: qcserial: add support for Sierra
 Wireless EM86xx
Message-ID: <Zyt52y7uc3u99p2V@hovoldconsulting.com>
References: <20241106105029.338457-1-wojackbb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106105029.338457-1-wojackbb@gmail.com>

On Wed, Nov 06, 2024 at 06:50:29PM +0800, wojackbb@gmail.com wrote:
> From: Jack Wu <wojackbb@gmail.com>
> 
> Add support for Sierra Wireless EM86xx with
> USB-id 0x1199:0x90e5 & 0x1199:0x90e4.

> 0x1199:0x90e4
> T:  Bus=03 Lev=01 Prnt=01 Port=05 Cnt=01 Dev#= 16 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=1199 ProdID=90e4 Rev= 0.00
> S:  Manufacturer=Sierra Wireless, Incorporated
> S:  SerialNumber=004403161882339
> C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=  2mA
> I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=10 Driver=qcserial
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> ---
> v3 changes: the entries sorted by PID
> ---
> Signed-off-by: Jack Wu <wojackbb@gmail.com>
> ---

Thanks for the update. Next time make sure you put the changelog here
after your SoB and the --- line.

As it currently stands you SoB is not included when I apply the patch.
I've fixed it up manually, but please remember this for your future
contributions.

Also, the patch revision typically goes inside the PATCH marker:

	[PATCH v3] USB: serial: ...

Johan

