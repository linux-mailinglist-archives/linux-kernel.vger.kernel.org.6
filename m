Return-Path: <linux-kernel+bounces-227545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C165915301
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 692F4B269C8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D15819D887;
	Mon, 24 Jun 2024 15:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="uKqcPmSc"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9961D53C;
	Mon, 24 Jun 2024 15:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719244650; cv=none; b=uc3DUx+5T2ZDuce5PJB+c4GUkw5qM8qg5/SCmRgzyRoUTX2UDIc/OitHHzAhuP5VTWRTG3/ZRF2djDGXLNUmI0+RNsWEbJxDHK1z2G+uumSpra2/K0xpkbwMOk5TqILL8ho6KbsEDJlb1zVE66VFuyF6AHL3IluKNHifoNkYjdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719244650; c=relaxed/simple;
	bh=+a5OFi0RBKQi6uK/ymWtcqYxq19LFosRH4DfuG1lwRU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=lvbR7dR4u94pnAHCe0j66TQNwwCdCwA+yN3Za0YUhTXb4Ie7bG4U0+nTpWjIZsNA9fsdb9beJ9oW+7mxqSii7gDctPEahnRcFV71CN16zcrmYD3pIDX+cvYaIXf+5ONGVG+1YoLIOwSw4HcW5PNcNIT1+XcrNmNJWk028zn2s4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=uKqcPmSc; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719244614; x=1719849414; i=markus.elfring@web.de;
	bh=+a5OFi0RBKQi6uK/ymWtcqYxq19LFosRH4DfuG1lwRU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uKqcPmSc5cEWX/5WSLqTxVpAadxpQhg3mX/S2vD69zcEmn7cPZNbgqbGqgjuY0k9
	 wGD/qg8Hp3gC3hm5UACPntUaXLMjjW8k38+rPz4mqtSQPC2ahX4qbQogKVjEsnnyp
	 RTRoCSMgiZdn8zvway/wGnmHVD6nl4m1bruQX6/CL26np9RlTcSbVLWimVhJ8HS5Z
	 2YYjPr7kY5y2hLqz/yAsAQlFe6Un1iKmE0zle068NG0J3pB62SLkKsBM/lioVUUTM
	 cLR0laK4vAY8Z4Uc9HMgdwJe6pUUSVOVGIJQ+0kXpri8MAwDkBfgduexl6uJxpjOg
	 io+eF7RN+LWh5YLp/g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MUU6E-1rvTkb4AxE-00OT1z; Mon, 24
 Jun 2024 17:56:54 +0200
Message-ID: <38b7ccb7-633a-4e51-9641-80ced078c33f@web.de>
Date: Mon, 24 Jun 2024 17:56:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ma Ke <make24@iscas.ac.cn>, linux-aspeed@lists.ozlabs.org,
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joel Stanley <joel@jms.id.au>, Neal Liu <neal_liu@aspeedtech.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240624015314.2249128-1-make24@iscas.ac.cn>
Subject: Re: [PATCH v2] usb: gadget: aspeed_udc: validate endpoint index for
 ast udc
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240624015314.2249128-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n9yAUzR7rUa1NUdrk6VIoK5KFZG38C7bA7iQ/Ktgk0bJ8VD3Nuf
 dU+fU9AXx4NjTI44p5YPf+TLaEZW45Pv9GxIUFd0B5zgG+uUE/CdTyfpTRyr9yJT6CBKv4q
 NLR/YD1jxLXWYTA1x0IoTiPDgGim8Dx2M7RWLCgN9mwONBRJpLTVDkU/HOEhjyD6Jm6y4ZH
 SL7zdzLb0TyHref5BCJpg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0mLxJAJCIkI=;TVIVJbyMhGebVxI5qelgVsBOcnR
 g+Atlb32+yBv3tHrc4+REgFzRfbZ9PqYKzQVNafNULkSUS7NtCzWNcLyCzhLIEmrbBglRnvvG
 QOrcX0eX7l04gAzjR2fsZU7qa6AHAtTtjQKcucvOnTmE2bwJqhFdijv3iBb6xvUUapD6pXCjf
 +JpZDVPLeREsJQZM/suVRXLCnujs3VQj2YmxebLirYYs48B70pqFCEybMET9WKjuC7G3bzukf
 dmAYYMsWYwI1n6sDRDpOmwIJGciMhvTZ8g3bdGMOqWefaiueZ9183qNaVIyqiEoeyVIFpnNbv
 Pf0yXU/pHZX+TrnVHS9rWT0cMyCyb+5p+4NasMmODthRbMoX17JuZdm33h+kR2ZJPwHcIBrOV
 njEL2pKzAP3gt4MwNWXzl3obJy/wCfRVd/ekB75Rcbbhvgvi38LCXJULajHC3xprktt98vV/B
 iPHULfcxlWdtD26VUd2fPBcNojdTA+gMwQeonoEpEwwiuW58aFdw1SrKnoTKTFJYW4ar3DevT
 +n60uynf4FrGhToi21l1RIWcRStYkntcextiIlSz6K466mVtUrw7znt9MnAkvPtUOfA3TwcHq
 xB6zKndnwrpOzhZf++Rj2l/MleX6vSxtkNT178URPF4bWjUcVIjy94ARjSV3N1soUR6OIZTSU
 gVF8qILwFIPmHOs+gNHaIfysyAAzVzY3ypIXjCkyo79o3wKxv4lQpruxPW67CFTddYBpzYMKu
 INbHKROPwxffqZMbXMoU+b6hxRWaYVBx4GJFdRsi6QsyK4Dh1iJ9xbwqFTkArbsSQL2DMX3rs
 fOiQoXNxy2LltSsEdA0qT0hFDDvlA52Ln+D+TQ79OEADg=

> We should verify the bound of the array to assure that host
> may not manipulate the index to point past endpoint array.

Why did you not choose an imperative wording for your change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc5#n94


> Found by static analysis.

Were any special tools involved?


Would you like to add any tags (like =E2=80=9CFixes=E2=80=9D and =E2=80=9C=
Cc=E2=80=9D) accordingly?

Regards,
Markus

