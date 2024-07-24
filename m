Return-Path: <linux-kernel+bounces-261014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C500393B196
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019C61C20BD0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF6A158D96;
	Wed, 24 Jul 2024 13:26:10 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA216158D80
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721827569; cv=none; b=a3NIwZ/8v5T/xRDNpxvqZX3DoRuUTNwdI6UmnAZvQSNcl3Oisc1hf/hvS5Sz93JAGfX4aPNrhcLXm8i1b9W+buKpN7tGbSEfVit1YCdL1O65oq2pxQQzrK0nTVbCYibBKtKx10NWTvFnhCm6U0fWo/VZeNA2HOJ7zDAYxojWZEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721827569; c=relaxed/simple;
	bh=GejOsulQKZ7DRhpMb5E2LNdpWt3Wv+X2w4i5T2Qcdqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R3CFk78IKlGvKXT1n85KxgsDIklqH3+/GrSMWwd43/OvWV8VN/X7/PKTddRmwXfd/eQxK02w3Q6LqKaRX2RqEbO52vv/yQYb47ieXzCrnIftjdv6/7fsXgroEeuhWn/L3XQttgCPyYpGxqeD3PwzJP9HK/nJArAQcnwHhJb9aAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 36C7B61E5FE01;
	Wed, 24 Jul 2024 15:25:54 +0200 (CEST)
Message-ID: <8021ff18-b277-4e6a-9a15-5e107ae5809e@molgen.mpg.de>
Date: Wed, 24 Jul 2024 15:25:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: get_maintainer.pl finds old email address not in MAINTAINERS
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org
References: <20240724111524.25441-1-pmenzel@molgen.mpg.de>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240724111524.25441-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Linux folks,


I sent a patch [1] using

     git send-email --identity=linux 
0001-USB-core-hub_port_reset-Remove-extra-40-ms-reset-rec.patch

with the git configuration below.

     [sendemail.linux]
     	tocmd ="`pwd`/scripts/get_maintainer.pl --nogit --nogit-fallback 
--norolestats --nol"
      	cccmd ="`pwd`/scripts/get_maintainer.pl --nogit --nogit-fallback 
--norolestats --nom"

That resulted in Gregs old SUSE address getting added:

     $ git describe origin
     v6.10-12246-g786c8248dbd3
     $ scripts/get_maintainer.pl --nogit --nogit-fallback --norolestats 
--nom 0001-USB-core-hub_port_reset-Remove-extra-40-ms-reset-rec.patch
     Greg Kroah-Hartman <gregkh@suse.de>
     David Brownell <david-b@pacbell.net>
     linux-usb@vger.kernel.org
     linux-kernel@vger.kernel.org

I am wondering where that address is coming from, and if I should change 
my git configuration?


Kind regards,

Paul


[1]: 
https://lore.kernel.org/linux-usb/20240724111524.25441-1-pmenzel@molgen.mpg.de/T/#u

