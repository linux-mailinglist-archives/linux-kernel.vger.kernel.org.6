Return-Path: <linux-kernel+bounces-560573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B58EEA606B3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 01:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051C616CA56
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 00:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954F0BA33;
	Fri, 14 Mar 2025 00:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="AFx6XJR5"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970762F29
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 00:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741913401; cv=none; b=hPXEXmEtHDUgZUOnXyQqML/68RaWBKczwRfU3EX4noLRkYKzBHOF7Lptw4P0LqpVAmsvYgWFYBPRetMCrYyu0XQJCqgjfibC4PqRImaE2DVEWKUt9y7DsHUIAJamGytSqrksiNr9Z1AtFT7PuvIICb5F6doAc3GDVZu5iHydlZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741913401; c=relaxed/simple;
	bh=BsFqqdzPuPWRngzuebETkpr8uorkLQTXRuJ/0YG5SB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bLuZMslRTgBNLDjVBOgvhDTMtZNIq3bRMWwl00TPHayri6q/T4GEenmhYepCNLf4DpJs/Izrmx4u17PxJ2y6JFOwUAjFtc5DAnnl7PEPBw+JXZvDR+tQ60YZCHD1G2rodHCAvKb1sab4DKtD1jQimv25DIvOwUmzU0Y6t/hxpsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=AFx6XJR5; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
	by cmsmtp with ESMTPS
	id sU7PtWa3tWuHKstFJtKqOF; Fri, 14 Mar 2025 00:49:53 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id stFItFqCWhQfUstFJtH2NS; Fri, 14 Mar 2025 00:49:53 +0000
X-Authority-Analysis: v=2.4 cv=Negt1HD4 c=1 sm=1 tr=0 ts=67d37d31
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=6Vi/Wpy7sgpXGMLew8oZcg==:17
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=Q-fNiiVtAAAA:8 a=F5-tGhwS0eEbiyZ0YyIA:9 a=QEXdDO2ut3YA:10
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kmWv7Y4KzQN5V+KsNOlfevV3PXyysfgElxT14QC99Uw=; b=AFx6XJR5pZLyEE+oM0qFbzWWtM
	6M8ZAalHpg7JZkYab1Pz1xjtJsL/K7A5POro0xv49MHDuF3BMLNwen1pkPgN3gZoJW8UXa6gSxD1n
	oE00+GEbtk3AeusLkq8ymYE+ghMEPsy4N6lemwqxLNIJyIK3wn3Sq+gJCslg6v9GtJiRpo2pVbsfT
	x0lO6+M3VqfFwfpjraxsRR7vQ3J0rU9NktZxSK2nAKnJrqNRltWX3nUgaIkqXjLRXwvCruExj7HxV
	HOT04kumgvIDSe5CGt0f8YxIBpBuRvB+J7qLpp84AXDx9sUKrHTFYbdErUiseo5JQTqeyMzGh2mpc
	WumPUkKg==;
Received: from [45.124.203.140] (port=53726 helo=[192.168.0.159])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tstFH-00000003OmV-0tFW;
	Thu, 13 Mar 2025 19:49:52 -0500
Message-ID: <18840a07-3a3d-4bfc-ab2f-50d1e8ce129a@embeddedor.com>
Date: Fri, 14 Mar 2025 11:19:50 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] misc: bcm-vk: avoid -Wflex-array-member-not-at-end
 warning
To: Scott Branden <scott.branden@broadcom.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <Z9Nd4AmgrQDiK1Gn@kspp>
 <547ce7ba-7042-70ff-8468-8e449be6fada@broadcom.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <547ce7ba-7042-70ff-8468-8e449be6fada@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 45.124.203.140
X-Source-L: No
X-Exim-ID: 1tstFH-00000003OmV-0tFW
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.159]) [45.124.203.140]:53726
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfF7CPYR+Fr4wupglbH/whUHaYuseCLRZQFvbAssM+9CKBXbpMPCiOmwzMQ3SSQ9vFqXKRX3o7/jK64eurSZ84M7Z12FGXrvBZanvWjhGI/LbWc18NbAY
 bl/bvecKWImaz6uEH8tWo+R0WTHKES3wWusSmFeaRgnUejtoYWE5H2sGz8VBAoi900gbHjM98EpTDmYDoi/eYNNbDALWeApUE1UZcH8m1eMRXgWj2EygTqyL



On 14/03/25 10:34, Scott Branden wrote:
> looks fine
> 
> On 2025-03-13 15:36, Gustavo A. R. Silva wrote:
>> Fix the following warning by removing unused flex-array member
>> `data` in `struct bcm_vk_peer_log`:
>>
>> drivers/misc/bcm-vk/bcm_vk.h:415:32: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at- 
>> end]
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Acked-by: Scott Branden <scott.branden@broadcom.com>

Thanks! :)

--
Gustavo

