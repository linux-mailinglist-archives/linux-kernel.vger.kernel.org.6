Return-Path: <linux-kernel+bounces-412248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9629D05F4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 21:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5093282119
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 20:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A0F1DD889;
	Sun, 17 Nov 2024 20:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="jomFyei4"
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9482E1DC184
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 20:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731876764; cv=none; b=BkQb9PI470SaNehvrSeg2rtyJ0mB8kA/Hz+hq17wi5SGRvAsja9TNXoAlx8R5xKi1OINia6MSOrm72Yr8G4a6lNhuTMczJlDFZTpWDYI1RgASIlbOD8WSXLamKArgdGFf8ZhGRbs4RrOO/9cMSRl06rHDnHZONHNown5jNL0i4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731876764; c=relaxed/simple;
	bh=YZPjXdN8hyCdHemnE5jLshMjS+y/JaTHEu54KLugluk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=cga74y5FyD2JDnZG49onyd+LOsJOY+gb7s/xSAaUbBBlkoIt5DQooxXO5iNK7KuF+XKUoubQNRD58G42elamAvMFFOV+Lc5xU/jIYt2C+uDAWypGRsFrVv0M1hK0Nkrt6Sxu2romvBV6NduvUtt3a11sBmbAt6Y/hRc98ra9AT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=jomFyei4; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D4A77600067;
	Sun, 17 Nov 2024 20:52:34 +0000 (UTC)
Received: from [10.252.34.165] (unknown [198.134.98.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 3CDE913C2B0;
	Sun, 17 Nov 2024 12:52:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 3CDE913C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1731876754;
	bh=YZPjXdN8hyCdHemnE5jLshMjS+y/JaTHEu54KLugluk=;
	h=Date:To:Cc:From:Subject:From;
	b=jomFyei4EITy64heYOjb+p9q1LSZKd8wP73V+W8WbmeQW/AeXzrzJPIYIC8tMFq+d
	 wL24cCdCu++ynclmKxRdBth+wqMftgEGpkJn6kt02/xPa58gOjeUrte+U9NUFpZma0
	 bQaNKHXE+tv+LNMuWg9bySF/3j/1synsjJ4q5YV4=
Message-ID: <f2aefd64-8881-4690-aacc-ad676c9826e7@candelatech.com>
Date: Sun, 17 Nov 2024 12:52:34 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Language: en-MW
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
From: Ben Greear <greearb@candelatech.com>
Subject: Bind wiregard interface to VRF
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1731876755-uEj5r1WQqF0Q
X-MDID-O:
 us5;ut7;1731876755;uEj5r1WQqF0Q;<greearb@candelatech.com>;36aee6e67036a1cc1127540b8af91e62
X-PPE-TRUSTED: V=1;DIR=OUT;

Hello,

I am interested in binding wireguard interface to a VRF.

I was thinking the parentdev option in 'ip link add' logic could be used to
set the bind_ifindex in the 'struct udp_port_cfg' object.  I didn't fully follow
this through to see if it could work, but it seems likely.

Something like:

ip link add wg1 type wireguard parentdev vrf1


I think as long as the UDP socket is created/bound with something similar to how
user-space applications often support --interface eth1 argument, then it would do
what I want.

I'm curious if there has been any effort in this direction or if anyone has suggestions
for most acceptable path forward.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


