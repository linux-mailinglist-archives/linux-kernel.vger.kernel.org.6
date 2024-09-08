Return-Path: <linux-kernel+bounces-320389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF3D970982
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 21:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E45791C21A3B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 19:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8761779B8;
	Sun,  8 Sep 2024 19:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vfjo+Bm1"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8C52206E
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 19:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725824153; cv=none; b=SPkKRaNsIDWUzIWftHFPBgXE4xkk444LNZ2DQhC1fzd6mUEeenUzl9dUemO2oNugGQv0uLSSgWPa960CcsWuINS1qS0mibI8VWq0Ctxq5YvrOKpP/tUL6ho9CtyL1wlm/GxUN45arEGAeLqEEJ7g4fiS8yCQAhcnmY20tNAaKOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725824153; c=relaxed/simple;
	bh=NsU2TUHsOYm+I0zW8NVcFgoRNha/E3lFdrDEXmkVDfM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EFBo+NT2VFER7l5SzFrsvH2/1lzUU6m+Z2Hm8hqY+6hm63jXOqs0t2M8qn3eGcXF8rs0yKhGQl8IjWnycQdlIMTAceci0aoUZOS9PxZeOd9NII6cllkPNbsnbIKvYsXISFOFkrgcOr8w/SobqKMqgjRRydDQ2gp80N4ahtHbOKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=fail smtp.mailfrom=grimberg.me; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vfjo+Bm1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=grimberg.me
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=p1jleCrcvcEsUgvoOnEF55ZwRx8+vaMRREkGzy163EA=; b=vfjo+Bm1TDyDY0GuD0d5ACAa9V
	p5MVHj9Xegp2R2V7VE9buZfW9alfpZeBIVfWvv9NvgM3t8htDq62XEou7LqxGYq3v75U08Oq0np+y
	i1GEroMnXR//Xx2XcDosgEGSOadumGEm7vQ/ml3PpcxGLtCYWNvTgpFNL41ZvtirPB/CZDJOYgyse
	7JGdwwslUQm28i/WhDHUPurSrNEsI6tP/DABuHQQ/NrB5RmW5MfoO0PQvRIu2uHvgCwoMbUMEmkRq
	TaEAGlQN19yGKbtJbPI89aOzfKt5mRlnooWsQ7Ao1aJ+Mi/ECWgeQQ8RwUaUh19F1HSVr2suZZU/v
	CjhMotxQ==;
Received: from 89-138-71-253.bb.netvision.net.il ([89.138.71.253] helo=[10.100.102.67])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1snNhE-00000001oXy-1cjD;
	Sun, 08 Sep 2024 19:35:41 +0000
Message-ID: <af8f2f8e-29ca-42cd-ae0b-bcdb707a96ef@grimberg.me>
Date: Sun, 8 Sep 2024 22:35:18 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] nvme: Convert comma to semicolon
From: Sagi Grimberg <sagi@grimberg.me>
To: Shen Lichuan <shenlichuan@vivo.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240906065815.40300-1-shenlichuan@vivo.com>
 <d3c63cee-cf99-4191-a434-aa1d36879184@grimberg.me>
Content-Language: en-US
In-Reply-To: <d3c63cee-cf99-4191-a434-aa1d36879184@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Testing again (sorry for the spam)...


On 9/8/24 22:31, Sagi Grimberg wrote:
> Again (now will hopefully make it to the mailing list after some dns 
> fixups)
>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


