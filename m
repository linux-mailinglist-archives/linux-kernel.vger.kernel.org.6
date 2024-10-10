Return-Path: <linux-kernel+bounces-359601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE74998DDC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 528D51F24D1A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C0A199939;
	Thu, 10 Oct 2024 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="WU/QxFGQ"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2F519924E;
	Thu, 10 Oct 2024 16:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728579288; cv=none; b=B4+X6LIf5er7m/acUM+Fy0C8KH8H4Tom9QNDJo1MtXPE8BTZV0ufYnAeu9H1rZo1JXMBPC67ahESDqGnzRW7M3inG4pZ6tAuYu736txaMN6WdO0fb77u/aL6VjL53mABACiK/wBSuz2RHYKjd7J9m/oxN98dwFhWgUkKapQ7pSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728579288; c=relaxed/simple;
	bh=W7Ll6piEDyX0bG2FVgt0Bklhp0ipwm36D8XfHAUQ+V4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lVL4IQhVmHSLxbYUWsn7E98dmLoeHZ3UDUOnAHuEHm3mv2WBTCeN4CPQwtA3mnCRWLV3YVhKPZu2bsOkZvcYltz1AWQLUrQpbeXTI7RrxQpmg4DiykVzTGwcNEF6TZOwgomhTxA8u12tGl7AvKN3mmWsGW8Mj0L5PgLS361iHnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=WU/QxFGQ; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1728579275; x=1729184075; i=wahrenst@gmx.net;
	bh=W7Ll6piEDyX0bG2FVgt0Bklhp0ipwm36D8XfHAUQ+V4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WU/QxFGQDQvsLIQdMcvZWC5rlDJ2mMde/DmSIeJevpNqMkMmfs0QGKZ5ohzjT9jA
	 MnDy3ky1k+sMTZNeplAe/BTSWzbG/fUmQHljHgQj0Fm9nju8hk+xQQK45ndOE1LiV
	 U54h9M2MsObEdk6AvPVYcdjwdMMlnmwiUSIx2UpfYUe7J6ST3SBkdeksRVu36WN85
	 0yih6oFB4qqn2hzl0gJBKtrfCXw4t7K16PLjWARmxt8+tdChOgrBZ7POqd6Ffsw5h
	 86VELK4VVayinb/M+E1fNGNt6cs71FLO3liWWqQth4K+dy8H2dSyGjeIXdiEEB/Vj
	 LsCZT/46OirYVlTenA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.104] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKsnF-1tFmze0USD-00Q5ul; Thu, 10
 Oct 2024 18:54:35 +0200
Message-ID: <420fbb40-db13-4907-b1b8-c0755fd0c2b2@gmx.net>
Date: Thu, 10 Oct 2024 18:54:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] staging: vchiq_core: Fix white space indentation
 error
To: Umang Jain <umang.jain@ideasonboard.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hridesh MG <hridesh699@gmail.com>
References: <20241010102250.236545-1-umang.jain@ideasonboard.com>
 <20241010102250.236545-2-umang.jain@ideasonboard.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20241010102250.236545-2-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:mAO10tJjaFCmfWAL0RYsUIwNm2/QIvRg9zXrbsffzxZLnzgbU92
 9AeNBz1zQXd4b23/6uHL/TPyAZ3yXFp9601ZKuDPaa7FgydPVPE8P6fREl0IlkTr0UzkhWm
 YrgrQvqnGaYjJjZ0xEZf6/KPQx51N6ca0+syYCoIinUIBfysBsIaBh4VeJTta0felkvNnBf
 EQUyfjGpkpmPdOmHijztA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pavCPIc6qE0=;kb+dhRaVh2GZZYKPRBjMb/Te/Kc
 uBTNRFUpNPBET2XVEpfRH+6bJYBKdA0wO/MM307EJJqTihF9uoky8LBHS+/BDtpbg13CHl8Od
 ZjEnKV35zzYrPwznJnkhgyZnaxlhT9vMwqyjtROHIygN6DT5l0ucBStk/gE7LYWndTUkJSBkx
 Yz1XFomnM6hJDZ2hHZnqoUPQa5S6n+cXfBD7fnFpoNvv1pv4nRZihiuTZIGtoilT/kYj3MNzS
 Mdw4b8J0hYdAgxuthRPeG91FlLphrEFIEKkF4Sa04BQOHpBAh26fEUtHMsYq4Ix2mmsQ1T5Vy
 dHQr3Uhes8tfzw3ve+vFjSdAr+W0zCqIvdAvOHxa8BWQNxCImjfISy187mduNOCM9leDlv9Ot
 OdHf5NZS/cLFjF028eESccjsuL7yas7vh47Kt00YVva5EVshrGrpTP3lFhyVMkbDaQ+vxPFT0
 X2mKjaV1F3RqEqatdtlrNw6fm5LBPW5Eb7y5YYM6APfK7jZFVhg4ZOjiqIVs6ObCSnHz4RHVS
 vxxju75U0pSUyAvNBS9rpNwkm/arc1lsOpBeoV/SVmEDSMp3UH7NZCXyUL+L/f62Xn2bNevzL
 dqw2hxvgaKRmzVfEN0GUuoUi8hGiSGJWt3KteXda59JWPzQcyf8knw9CohhYBuHN8knvq/W2s
 y/IbmJqbLi56Ox4IfgadWGiPFjTtdTkAFHe0YhgEabA8IPGyloGmCPF8fa0TcCE0pffcgKD3t
 nrnpCPK98caRlbVuPUQ3Gtp6kZaYj5TgZXw4fkamfSfGwTCEe9xdtuKIJPyQDXyx7orSmdNTG
 rbalXW+YDvZo4d33kU8X1rsQ==


Am 10.10.24 um 12:22 schrieb Umang Jain:
> From: Hridesh MG <hridesh699@gmail.com>
>
> Replace spaces with tabs to adhere to kernel coding style. No
> functional changes intended in this patch.
>
> Signed-off-by: Hridesh MG <hridesh699@gmail.com>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

