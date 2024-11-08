Return-Path: <linux-kernel+bounces-401850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4509C201F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0530284333
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEFE1F5844;
	Fri,  8 Nov 2024 15:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=skogtun.org header.i=@skogtun.org header.b="7XDt/9sD"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95661F4FC8
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 15:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731078750; cv=none; b=Xgmuul2gAZ02H9i5t0OInqCzfd79DO+CBZELMg5U2EsU6GZvVpYXjyzOyxRfumwcQcZ26nAxnUsG9Uwcej65eIg8w9zHoT88Zz5wtb6UfAD/C2PUyzo00YNkpk0xogYynvJsCtGELwQZbobd7EDNoq9TOlSFl6i1P/ZXjLAc1Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731078750; c=relaxed/simple;
	bh=pB5hKTlNnPbH7L2qcwCIlroa67v10U2DfpF0jwsNvBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j7hIuPFUhKQMpiSl0tztwZGgSjOCx9CmC+6Ug5yritHIrbPaO2Kpq6meuW56Rfn+lhwKpYElUTGalGBtCSc/ZXPVBurhQ/0AHG2k8fca91uoOdxL3kFagHlhETPDRIgeOq2ilBTTMSuspEqYUo1QbQEeNoSah6CdIbu83s5veIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=skogtun.org; spf=pass smtp.mailfrom=skogtun.org; dkim=pass (2048-bit key) header.d=skogtun.org header.i=@skogtun.org header.b=7XDt/9sD; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=skogtun.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skogtun.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=skogtun.org
	; s=ds202312; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:
	Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=m9KNQYKKXeeykuZBwDGjsW+qvLDcewA69SOG2PRvurA=; b=7
	XDt/9sDo9Yx28ct5O3xDSpsQbsdrD9F2/YSjPbm/8xn0F5xiGlhR8Hz3a8OFTsV0plwqoA6jqob4t
	Q8kH1ahnt8Q4T8r7NgfW1LdsprXHp+ReKpdyvRSZKI+JtsVJ4DsMh2eiHMJIU9LvO7i9tIWHPHjKH
	FLuHYLKD+yTOalGcPZcLIetYj8ssuTmJQqjD+GkU42BKt8qIZHys/eYjopBAZGkBgpjhjAQgBK5aZ
	drdy78b/WOzft5AuXe4d04PW9CqaWS3YmJPc5f0wB+YdyNOueILCd5nPere7eSUYTH3D9e/H86Ru2
	egV125xHg7V4JuOx6SN4c3NwO87Fz7F7A==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1t9QY2-00CSMU-OW;
	Fri, 08 Nov 2024 16:05:18 +0100
Message-ID: <93f4889a-90ed-460d-b5bc-d566031b75d3@skogtun.org>
Date: Fri, 8 Nov 2024 16:05:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Q: Kconfig: 'If unsure, say N'
Content-Language: en-US
To: Diederik de Haas <didi.debian@cknow.org>, linux-kernel@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>,
 Sudeep Holla <sudeep.holla@arm.com>
References: <D5GVI1Q30BTS.1ZVQ4YC4OJYEL@cknow.org>
From: Harald Arnesen <linux@skogtun.org>
In-Reply-To: <D5GVI1Q30BTS.1ZVQ4YC4OJYEL@cknow.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Diederik de Haas [2024-11-08 15:39:30]:

> In quite a number of Kconfig help text entries I see this:
> "If unsure, say N."
> 
> But that raises the question: How can I be sure?

I usually interpret this as "If you don't know that you need it, you 
probably don't".
-- 
Hilsen Harald

