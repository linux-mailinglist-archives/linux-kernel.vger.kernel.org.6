Return-Path: <linux-kernel+bounces-169563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B378BCA70
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF6528393A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD991422D6;
	Mon,  6 May 2024 09:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="bia3kAVZ"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF091422AC;
	Mon,  6 May 2024 09:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714987238; cv=none; b=mqM+zGdxW2++J7mrOmVtEcNPDQfa19STGuONf3oBw80/6S3wH2+bpsOgOgjXNli3aFoauj8HzJSgcI+Z2dDaVwy4eILksW0XdnMzDnu6jKix5CPTPlbsVmrvow5qCOI1pkfuK22AdxgeakUm086DFvt221tEFInB8zAN2S4OVos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714987238; c=relaxed/simple;
	bh=PQytnEGjJh8JMaq9PKzKuAqWRJ/iFQlt/JLPHpUp8rA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=krvGlg9y0uCehSeG7iOjwN1ZtmeFwjEQpwRFXBIzcWlSYXdN6YVp2WFQdUfzWlejzqHIm053/19P+WYHlAGhT8Hng/rf3ymYZxKMp485/h/bDKYOd/ReevteRcf5x7gZJya9QErkqArglb5+5C+qK0JyxVuurdo4KdEXDFidsIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=bia3kAVZ; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id B0EC7600A2;
	Mon,  6 May 2024 09:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1714987232;
	bh=PQytnEGjJh8JMaq9PKzKuAqWRJ/iFQlt/JLPHpUp8rA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bia3kAVZKNL0yRW4zOVPbcm2km86aipI/gdtPm/xKmr9mQToz+ytRZFkNNHAaADBH
	 3lZ9LZ84NBBST9D+D1WkQL58T9g8u39Ig6twwGyJCHxxGMoCcYEO/t5eH+WmuBbBim
	 vtsqzpP6AQwrgRFG9hPA+WU1GV3Jkni4XSOXJv8n2iDsDrWXPthavHFKBojokDL4ku
	 LSfY/nhKwfsqx5z2spvVTsGeJ91bUbw92uYp4LvTz3w7b9cVx7F+/GmZuQpr2+0QP2
	 UPhh2T0Tjp9IuvsDrqVB81Ow6PDNiKn+dlAHcF+anhCOHDzwXpoeZykYZi4hd/CFUj
	 ILfGjYezIjS3A==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 00A5B20146D;
	Mon, 06 May 2024 09:20:27 +0000 (UTC)
Message-ID: <af4986b8-e868-4540-852f-7dba5e3196d8@fiberby.net>
Date: Mon, 6 May 2024 09:20:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] iavf: flower: validate control
 flags
To: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Eric Dumazet <edumazet@google.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
References: <20240416144325.15319-1-ast@fiberby.net>
 <PH0PR11MB501366480345AB20618700D1961C2@PH0PR11MB5013.namprd11.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <PH0PR11MB501366480345AB20618700D1961C2@PH0PR11MB5013.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sujai,

Thank you for testing.

On 5/6/24 5:30 AM, Buvaneswaran, Sujai wrote:
> HW offload is not directly supported on the iavf VF interface. VF traffic can be offloaded only through VF port representor device which uses ice driver.

Again, there is a awful lot of flower code in iavf_main.c, if it's not supported.

Try with:
ethtool -K $iface hw-tc-offload on
tc qdisc add dev $iface ingress
tc filter add dev $iface protocol ip parent ffff: prio 1 flower dst_mac 3c:fd:fe:a0:d6:70 ip_flags frag skip_sw hw_tc 1

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541

