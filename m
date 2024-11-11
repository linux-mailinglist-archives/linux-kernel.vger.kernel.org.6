Return-Path: <linux-kernel+bounces-404845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9E19C4908
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 23:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8096284555
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 22:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E43150990;
	Mon, 11 Nov 2024 22:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="bdJ5RNfd"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E2E16C451
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 22:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731363788; cv=none; b=Shn6M4ddnFhdpE5ruGqxf0rnUir8IaimrpZ9zA4Dtn2liYqrIbsR6K3Jxvj+HYS4qHecVwYN5Z5J78NtzgmSxaz1B2UtwcLDE8oiu+WXvSgkQdredu7eQ+U685743/6kJh2JNsloHhoAelNMf0Div+lq/gZe3a+MAcIN6kDWXS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731363788; c=relaxed/simple;
	bh=oEkq5JQuZ0g+PteOabUnceUzJjXO3FWbvb0iXjHZDpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oIJGQP/iQFPfXU16nvXX9mgrHtMdzOdwIymo/cDbKhgmF6gIZzdkbjH//0LHf8GZ9AP0UeRxsYmCytR9Dspzqo0pyZQkTQTNsQBXKUHcE0abQF6ufq1cNwUcWycifjZk9m1S+NnO1GyNwcr0ekZT+/GPjM3dJUbncWJvOIRUBe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=bdJ5RNfd; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTPS
	id AUa3tXSybvH7lAcoFt8h5c; Mon, 11 Nov 2024 22:22:59 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id AcoEt1J9P2oH8AcoFt97jO; Mon, 11 Nov 2024 22:22:59 +0000
X-Authority-Analysis: v=2.4 cv=aKb2q69m c=1 sm=1 tr=0 ts=673283c3
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GtNDhlRIH4u8wNL3EA3KcA==:17
 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=7T7KSl7uo7wA:10
 a=vVgwA9Hib2JlT8r2P8IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QuuLV8RyuuVn5LsdO/A41b5qscG32jUw1xdRZuRx+yg=; b=bdJ5RNfduZCRpxWEX6hIqSthKH
	FTrrIIZTFqrF5L1x6K8hpRT2ePufSi0hTV+ZvVn7Hu2iwPJsIny4fU3k9NnazJIltpgU+RnjCf8lh
	4V8sqkmVATnc14qcYUH4wDC0yuL0VqRPoyinpwa0tBF6g7fas+g4K9seXUJt5GdTLZ+lyvH2L5vOr
	uRpfWWIxhtPZmVFpaUND1UH9U5X03mf7jZW6ZfKeABx6TwirDJO2jqcvv5mI96xYT79AQzqjiW8f7
	9QX2R35vsLfgem1jEXapJBYlYcvl37s9uVkZNi2Xov+k/q0nctJrNDP5ApNxSsR8k/wBSPCNj+NV7
	4rz8BzeA==;
Received: from [177.238.21.80] (port=27680 helo=[192.168.0.21])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tAcoC-001lqJ-2Y;
	Mon, 11 Nov 2024 16:22:56 -0600
Message-ID: <d4f0830f-d384-487a-8442-ca0c603d502b@embeddedor.com>
Date: Mon, 11 Nov 2024 16:22:53 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2][next] UAPI: ethtool: Use __struct_group() in
 struct ethtool_link_settings
To: Jakub Kicinski <kuba@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Potnuri Bharat Teja <bharat@chelsio.com>,
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>,
 Manish Chopra <manishc@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Kees Cook <kees@kernel.org>
References: <cover.1730238285.git.gustavoars@kernel.org>
 <9e9fb0bd72e5ba1e916acbb4995b1e358b86a689.1730238285.git.gustavoars@kernel.org>
 <20241109100213.262a2fa0@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20241109100213.262a2fa0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.21.80
X-Source-L: No
X-Exim-ID: 1tAcoC-001lqJ-2Y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [177.238.21.80]:27680
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNOrfkgLaGBrfr/2eKt4iNNVrlHdnlyEuzjAzLlvs2fPBX0g6ICLH1PRDNnUAEDCBOsgiATyLRyhvmLHKuLx3JFTKb169Jndt3scYLvMXYqG/lgtFfwr
 es0YFYpR/V3PAL5LRrMxGoX9aVA5ghhFtCdJpnuFmQYnm7z7sPkg+G3WDIoA4J15yqk7zYvZhG4GEO8GBZOkJSonv06sklpjEvnB1c9lJCx13Cuy1PiC2Pv8



On 09/11/24 12:02, Jakub Kicinski wrote:
> On Tue, 29 Oct 2024 15:55:35 -0600 Gustavo A. R. Silva wrote:
>> Use the `__struct_group()` helper to create a new tagged
>> `struct ethtool_link_settings_hdr`. This structure groups together
>> all the members of the flexible `struct ethtool_link_settings`
>> except the flexible array. As a result, the array is effectively
>> separated from the rest of the members without modifying the memory
>> layout of the flexible structure.
>>
>> This new tagged struct will be used to fix problematic declarations
>> of middle-flex-arrays in composite structs[1].
> 
> Possibly a very noob question, but I'm updating a C++ library with
> new headers and I think this makes it no longer compile.
> 
> $ cat > /tmp/t.cpp<<EOF
> extern "C" {
> #include "include/uapi/linux/ethtool.h"
> }
> int func() { return 0; }
> EOF
> 
> $ g++ /tmp/t.cpp -I../linux -o /dev/null -c -W -Wall -O2
> In file included from /usr/include/linux/posix_types.h:5,
>                   from /usr/include/linux/types.h:9,
>                   from ../linux/include/uapi/linux/ethtool.h:18,
>                   from /tmp/t.cpp:2:
> ../linux/include/uapi/linux/ethtool.h:2515:24: error: ‘struct ethtool_link_settings::<unnamed union>::ethtool_link_settings_hdr’ invalid; an anonymous union may only have public non-static data members [-fpermissive]
>   2515 |         __struct_group(ethtool_link_settings_hdr, hdr, /* no attrs */,
>        |                        ^~~~~~~~~~~~~~~~~~~~~~~~~
> 
> 
> I don't know much about C++, tho, so quite possibly missing something
> obvious.

We are in the same situation here.

It seems C++ considers it ambiguous to define a struct with a tag such
as `struct TAG { MEMBERS } ATTRS NAME;` within an anonymous union.

Let me look into this further...
--
Gustavo


