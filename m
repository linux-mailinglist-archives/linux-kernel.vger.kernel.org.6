Return-Path: <linux-kernel+bounces-447917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CCB9F3883
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70B116D979
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A717E20D502;
	Mon, 16 Dec 2024 18:05:05 +0000 (UTC)
Received: from sub0000529476.hmk-temp.com (mail.btob-mail.work [180.222.184.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77769206F2A
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 18:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.222.184.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372305; cv=none; b=PtB6ZgS6GTIMrh4qLvbqhqcNsH3FwL+jCv2tQP9vLuiOQX3ALC1INwB4lKRyeb2Docymrvc7kj2x7wsEQoWjDBqXi1UVwsdmut5934ZGZdk3gyPeJyAFSY5+QdRVWB2BjK3//2JmZ2rGjs+Xno3kT/r0cHhZiVEqK4G9DRKJ/ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372305; c=relaxed/simple;
	bh=s5RkDWMsPAAnwYzVTws6XjcFf+hcblKo4FwS7fr7Sis=;
	h=From:To:Subject:Content-Type:Date:Message-ID; b=Zax7iZeIcjXiHKqV4pXLfzMo3zscAs3sG7mgm6vFeKhFYjOUl+J3g7YMUR8NE0gs3S5g1UmGhbFyvwwu4Qj7ttxNWpbwu602JV2c7gJdcFSNzuZqOuSbiVlubMCO4g50fTMzfdLT8TRQ+9xmV1r2ZkQ9Zyf1jpJ00dfrz9/vHbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=saiyo-shien.biz; spf=fail smtp.mailfrom=saiyo-shien.biz; arc=none smtp.client-ip=180.222.184.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=saiyo-shien.biz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=saiyo-shien.biz
Received: (qmail 4166 invoked from network); 17 Dec 2024 02:06:22 +0900
Received: from ai126183159074.57.access-internet.ne.jp (HELO DESKTOP-K0R8I4G) (126.183.159.74)
  by mail.btob-mail.work with ESMTPSA (DHE-RSA-AES256-GCM-SHA384 encrypted, authenticated); 17 Dec 2024 02:06:22 +0900
From: =?iso-2022-jp?B?V2l6Qml6GyRCM3Q8MDJxPFIbKEI=?= <info@saiyo-shien.biz>
To: linux-kernel@vger.kernel.org
Subject: =?iso-2022-jp?B?GyRCNDE4eEQjJCw1LjxSPiY6YCRyR2MkJCReJDkbKEI=?=
X-Mailer: Mail Magic Professional Version 16
Content-Type: text/plain;
	charset=iso-2022-jp
Date: Tue, 17 Dec 2024 02:57:52 +0900
Message-ID: <202412170257520736.3655EE5465E24AC99F3DCE65C0E61EDA@btob-mail.work>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

お世話になっております。
WizBiz株式会社でございます。

さまざまな経営のお役に立つ情報をお届けしております。

国（＝官公庁）が中小企業との取引に使う費用として
予算化している金額は、約5兆6,000億円（令和5年度）。
実際に国と取引をしている企業は全体の「15%」しかありません、

これだけ大きな予算＝マーケットをいかに攻略すれば良いのか？
そんな疑問を55分で解消する無料セミナーを開催致します。

◆オンラインセミナーの詳細・お申込みはこちら（無料）
https://wizbiz.jp/seminar/40384/

国＝官公庁といっても、営業ターゲットになるのは、霞が関の中央省庁だけではありません。
全国各地にターゲットはあります。全国にどれくらい官公庁があるのかを調べてみました。

〜北海道・東北地方〜 1017先
北海道、青森、岩手、宮城、秋田、山形、福島の７道県

〜関東地方〜 1297先
群馬、栃木、茨城、埼玉、千葉、東京、神奈川、山梨の８都県

〜中部地方〜 755先
静岡、愛知、岐阜、三重、福井、石川、富山、新潟、長野の９県

〜近畿地方〜 534先
滋賀、京都、奈良、和歌山、大阪、兵庫の６府県

〜中国・四国地方、九州・沖縄地方〜 1,328先
岡山、広島、山口、鳥取、島根、香川、愛媛、徳島、高知、福岡、佐賀、長崎、大分、熊本、宮崎、鹿児島、沖縄の17県
（順不同）

各地にこれだけの官公庁＝国の行政機関があります。（WizBiz株式会社調べ）

実は、皆さんの地元にあるこれら国の行政機関が、
新規開拓にはうってつけなのです。 その理由は・・・

★国の行政機関は地元の中小企業と取引しなければならないという法律がある
★そのための年間予算は、５兆６千億円を超える（令和5年度実績）
★入札以外にも国と取引する方法があるのに、そんなことを知っている経営者はほとんどいない
★実際に、国と取引している中小企業はわずか15％しかいない
★つまり全国の15％の企業で５兆６千億円が独り占めされており、85％の企業は蚊帳の外にいる

つまり国は、地元中小企業と取引するために準備万端なのに、
中小企業側がアプローチしていないのです。

この事実に、もったいないと感じた経営者様、
ぜひ一度セミナーをお聞きになり、国との取引にチャレンジしてみませんか？

◆セミナーの詳細・お申込みはこちら（無料）
https://wizbiz.jp/seminar/40384/

【セミナーで解説する内容を一部ご紹介！】

◎国は中小企業と取引しなければないらない、という「法律」
◎売上アップ以外にも存在する大きなメリット
◎どうやって国と新規取引をすればいいのか？
◎実際に発注を受けた中小企業が国から貰っている金額

マイク、カメラ不要の無料セミナーとなっております。
お気軽にご参加ください。

◆セミナーの詳細・お申込みはこちら（無料）
https://wizbiz.jp/seminar/40384/

===================================
メールの配信停止をご希望の方はお手数をお掛けしますが、
以下よりお手続きをお願い致します。
https://form.os7.biz/f/ed730f94/
===================================
運営会社：WizBiz株式会社
住所：東京都港区芝5-16-7　芝ビル3F
電話：03-6809-3845
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

