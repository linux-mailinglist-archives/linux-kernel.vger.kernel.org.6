Return-Path: <linux-kernel+bounces-360027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D719993A0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 22:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1376A1F23028
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9C61DFD84;
	Thu, 10 Oct 2024 20:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="bIMaU8TE"
Received: from mx04lb.world4you.com (mx04lb.world4you.com [81.19.149.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE791D0E10
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 20:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728591919; cv=none; b=S5bHYN9EIQcBT8g+TLkLGu6RxTku83ltXosTTMyQdMHulKyx1pFGRm4CE9BWt060sLtLySF6zHYP19kbsTiDOsk+Ia/qYBQllvoJGhm4h7pci/nrsXfV8oSTVqfIbvOffFP+/Tr3AI7p0KLFphaaJf0ywnlIJrh54uCM8PucmxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728591919; c=relaxed/simple;
	bh=5qc2uLKtcng0Pbn4QgiTyzAIaDW5ySBZ4olEDvBdt8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=doaeyoIjFITWmHkysx0ASGBLPGeLqie9S+gkMkofIyOncLI0Tx0m8lc/pdUL8p5pFpQ1J1lFvLX42NGlJDk3/5bkS5eBXBqYRiCM/eo/Xo/aayt+/PEdMU2nKpppgWQMydGDXyBx5cQ4BRO8HdV0J3TQLJ3UKdCwlVCKe2snpd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=bIMaU8TE; arc=none smtp.client-ip=81.19.149.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WIszEjML8mTs5AA53t+/xCrTzFI6TfvvQCFOYTlehB0=; b=bIMaU8TEvyrFU+JMrk7ZQGq626
	5NRsVJf4spONbLzBcfHdUQRdltmXaXvs6vzw7r37wvlAfykl+S75MJw/gJeviFo3ezaTQdmCmMsQN
	tmOLIJDSEFjNbj8vgx7PSfsXjUG57MeSGM1MDQyjG7d5RDLzqcX7Y3B9lm8DN9ReCui8=;
Received: from [88.117.56.173] (helo=[10.0.0.160])
	by mx04lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1syzEV-000000003dn-3QQK;
	Thu, 10 Oct 2024 21:53:59 +0200
Message-ID: <fdd45a82-bf05-4e03-bac2-cb670bbf5200@engleder-embedded.com>
Date: Thu, 10 Oct 2024 21:53:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] misc: keba: Add SPI controller device
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de,
 Gerhard Engleder <eg@keba.com>
References: <20241009202949.20164-1-gerhard@engleder-embedded.com>
 <20241009202949.20164-2-gerhard@engleder-embedded.com>
 <2024101026-scoured-conductor-c92e@gregkh>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <2024101026-scoured-conductor-c92e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 10.10.24 09:12, Greg KH wrote:
> On Wed, Oct 09, 2024 at 10:29:44PM +0200, Gerhard Engleder wrote:
>>   static void cp500_register_auxiliary_devs(struct cp500 *cp500)
>>   {
>>   	struct device *dev = &cp500->pci_dev->dev;
>>   
>>   	if (cp500_register_i2c(cp500))
>> -		dev_warn(dev, "Failed to register i2c!\n");
>> +		dev_warn(dev, "Failed to register I2C!\n");
> 
> Nit, this doesn't have anything to do with the original commit message,
> please be more careful when splitting patches up into a series.

Yes, I also did some variable renaming, which should be moved to a
separate commit. I will be more strict in the future.

Thanks!

Gerhard

