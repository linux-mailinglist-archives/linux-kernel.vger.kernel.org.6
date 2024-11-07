Return-Path: <linux-kernel+bounces-400810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 881F19C12A7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9AF91C226B2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F66C21732F;
	Thu,  7 Nov 2024 23:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="bqOTL1V0"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564721EF923;
	Thu,  7 Nov 2024 23:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731022773; cv=none; b=dcWWY1MJsRTSRiSoPQWp6BDB3JkS2A8nKnE5lutIlpm3j9KNZARD3npvhH6rHWu8Afvm+Lq9r/L9Pu0Weqzhr1gLhMXVNFH89FFpmpUEXrhUyVVIkF5kParVQGvmKnlnAtUDPVVGvJj1dPKZ1nF1rlCv+EyaDUjuNRIWxhaxrGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731022773; c=relaxed/simple;
	bh=A5bjyyAWYr+VR/DxJGgp7mRweAiKTLFWuDoMtqHPdt4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ljuDcgMJvNuyG/QQxrHK/Igaf41mo7XhCf0UYUSUlXZ0+aDF3nW6odzSFz+vZkT00ixEXBM5ojMFE/lcZsJoxaImgrKoONk/tTEh7fLPXYnTAflHmyHgV+zopDaP0yrNF6tgQ6UWu7VE9CsturNMBsMaNLnkJRv4SyqtaaqLnCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=bqOTL1V0; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1731022768;
	bh=A5bjyyAWYr+VR/DxJGgp7mRweAiKTLFWuDoMtqHPdt4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bqOTL1V0niQ4ld27SUYcHlDmAaoq5xSdE6TM4Cu7mkF2RsEJpecqiqyVPuUWIGNTQ
	 ICeHH8E6VMmRL/ULBPyjNck8NZar70M3f+zzThxoac1+zdqPdiiMrkzs4C7+bcp99z
	 axJyWMyc4x/hr9s/0Q0Aj5PMHlc/YeR54n+Bjj1Hgn59bxgRW2Siyhf44zq/Q4IDfq
	 C+qwyMxmczr1dL5D3Rq6H39SlHeiDYjRWeMIaTVN2F9ete38v8BRjqJLMcET5rIJqG
	 XogJixa7Ie4sXmj0XViwanp/VzRMD6l4uwBb2YTQRRKiKpnp1fhz/n49FnwzomV4UP
	 TvY7qz6AgVqIw==
Received: from [192.168.68.112] (ppp118-210-167-185.adl-adc-lon-bras34.tpg.internode.on.net [118.210.167.185])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id AB35C6B922;
	Fri,  8 Nov 2024 07:39:27 +0800 (AWST)
Message-ID: <696cbaeefd0f731a1883771da3caa308ffcd03d5.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 1/2] ARM: dts: aspeed: catalina: update pdb board
 cpld ioexp linename
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Potin Lai <potin.lai.pt@gmail.com>, Patrick Williams <patrick@stwcx.xyz>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 devicetree@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org,  linux-kernel@vger.kernel.org, Potin Lai
 <potin.lai@quantatw.com>, Cosmo Chou <cosmo.chou@quantatw.com>
Date: Fri, 08 Nov 2024 10:09:27 +1030
In-Reply-To: <20241107-catalina-cpld-ioexp-update-v2-1-d7742eabc0e6@gmail.com>
References: 
	<20241107-catalina-cpld-ioexp-update-v2-0-d7742eabc0e6@gmail.com>
	 <20241107-catalina-cpld-ioexp-update-v2-1-d7742eabc0e6@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-07 at 20:39 +0800, Potin Lai wrote:
> Due to there are huge changes of PDB CPLD IOEXP pin definitions since
> DVT version,

If this is a different (revision of the) board, maybe it should have a
different dts file?

See the on-going conversation on v1.

Andrew

