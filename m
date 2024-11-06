Return-Path: <linux-kernel+bounces-399055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F5E9BFA47
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 00:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDE5D283565
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 23:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C0B20E309;
	Wed,  6 Nov 2024 23:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="JX+IWwM2"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DBA383;
	Wed,  6 Nov 2024 23:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730936519; cv=none; b=c6XUi1fPHVmA/Jl0oSvWcPetPHAUcELf8EMzA4/sGwgt9eQvcezSV1XY23Ok9YQoF78lOurDmpFHPiNCR90v7pf6l2sNyZZDE2XUmwO9AVr3nzvpQeYUpE4Z9nLvrD5f7FIAKr1r4XsyRhxKY0Q5RGRl8B+vXXsuA5sqLqoWXUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730936519; c=relaxed/simple;
	bh=V35WscTPJJZa0kbCQI1v1lpPEhxmxrS3QjHONqjJA1Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IGwHyfZc0Jfhb6Yu5kGUdpxQklz+4+XHVn+IGJmW/IYUW4vrFVQDiZ+PJkjtgViKUlzNuaxRwPMn2OzN1SQlV51WKmQ8NBX4vb40xtxyuIoACStESxqdd7DhNu3eXJpV3TXChVfXBDdOg0gzGCQT+4YUEvL5CAtm6xTimhRaiJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=JX+IWwM2; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1730936515;
	bh=V35WscTPJJZa0kbCQI1v1lpPEhxmxrS3QjHONqjJA1Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JX+IWwM2IZKC33djCGZllfdL1g6kzRmzqS2dbraQZ9yX2gxdN200kEeNQAPxmmw/b
	 3ZMLeAZDM+IUbU0IczUPvUIwlK6HBNfxcl9jnimW+gI7Jaj4ksKEPptl6vsCwcJ6/L
	 ppnYjq2NZn7T/gev1C9gOlYyPKpqbbYowo7vxCe62tCqYwkyUbK/GJfc/lBonbPuiQ
	 +d+NIVAYzSMPNg7nBfjM8+KNC6BrRxWd2rs/mTn/Yfe5UPGuLs/5+rCXQVYLHW6/aB
	 80pi1JjzLatvGOxIJ/rJvF9fpjD9Idt5igM0JL7oKKTnNpFoltR4hj5HzItHyUh9sd
	 lLSpdH2zzHWNQ==
Received: from [192.168.68.112] (203-173-7-89.dyn.iinet.net.au [203.173.7.89])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0F8706B4F1;
	Thu,  7 Nov 2024 07:41:54 +0800 (AWST)
Message-ID: <8e858e760c78ddf533e9e03c20b34fce29862c2e.camel@codeconstruct.com.au>
Subject: Re: [PATCH 1/2] ARM: dts: aspeed: catalina: update pdb board cpld
 ioexp linename
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Potin Lai <potin.lai.pt@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>, Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Potin Lai
	 <potin.lai@quantatw.com>, Cosmo Chou <cosmo.chou@quantatw.com>
Date: Thu, 07 Nov 2024 10:11:53 +1030
In-Reply-To: <20241106-catalina-cpld-ioexp-update-v1-1-3437bcfcb608@gmail.com>
References: 
	<20241106-catalina-cpld-ioexp-update-v1-0-3437bcfcb608@gmail.com>
	 <20241106-catalina-cpld-ioexp-update-v1-1-3437bcfcb608@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-11-06 at 16:58 +0800, Potin Lai wrote:
> Update the GPIO linename of each PDB CPLD IO expander based on latest
> CPLD firmware.

What version is the latest CPLD firmware? What was the previous version
with the old pin assignments?

I'm also interested in some discussion of the coordination between CPLD
firmware, the devicetree and the BMC userspace configuration. This
change feels pretty painful.

Andrew

